{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Lib
    ( AppState
    , App (..)
    , runAppRoutine
    ) where

import ClassyPrelude
import Domain.Server
import qualified Adapter.InMemory.Server as Mem

type AppState = TVar Mem.ServerState

newtype App a = App {unApp :: ReaderT AppState IO a}
    deriving (Functor, Applicative, Monad, MonadIO, MonadReader AppState, MonadUnliftIO)

instance SessionRepo App where
  newSession = Mem.newSession
  getSessionData = Mem.getSessionData 
  debugGetAllSessions = Mem.debugGetAllSessions 


runAppState :: AppState -> App a -> IO a
runAppState state app = runReaderT (unApp app) state 


runAppRoutine :: App a -> IO a
runAppRoutine routine = do
  state <- newTVarIO Mem.initialServerState
  runAppState state routine
