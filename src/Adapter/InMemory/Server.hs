{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}
module Adapter.InMemory.Server 
  ( ServerState
  , initialServerState
  , newSession
  , getSessionData
  , debugGetAllSessions
  )

 where


import ClassyPrelude
import qualified Domain.Server as D
import Data.Has (Has (..))
import Control.Lens ( (&), (^.), (%~), makeLenses )
import qualified Data.Map as Map


type InMemory r m = (Has (TVar ServerState) r, MonadReader r m, MonadIO m)

data ServerState = ServerState 
  { _serverSessions :: Map D.SessionId D.SessionData
  , _serverUserIdCounter :: D.UserId
  } 

makeLenses ''ServerState

initialServerState :: ServerState
initialServerState = ServerState {
    _serverSessions = mempty
  , _serverUserIdCounter = 0
}


newSession :: InMemory r m => Maybe D.UserId -> D.SessionId -> m ()
newSession mayUid sid = do
  let sessionData = D.SessionData { D._sdMayUserId = mayUid }
  tvar :: TVar ServerState <- asks getter
  liftIO $ atomically $ do
    state <- readTVar tvar
    writeTVar tvar $
      state & serverSessions %~ Map.insert sid sessionData
  pure ()

getSessionData :: InMemory r m => D.SessionId -> m (Maybe D.SessionData)
getSessionData sId = do
  tvar :: TVar ServerState <- asks getter
  state <- readTVarIO tvar
  pure $ Map.lookup sId (state ^. serverSessions)
  

debugGetAllSessions :: InMemory r m => m (Map D.SessionId D.SessionData)
debugGetAllSessions = do
  tvar :: TVar ServerState <- asks getter
  state <- readTVarIO tvar
  pure (state ^. serverSessions)
  