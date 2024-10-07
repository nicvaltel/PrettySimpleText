module Adapter.HTTP.Web.HtmlTemplates.ExampleIndexPage where

import ClassyPrelude
import Text.Blaze.Html5 (Html, (!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A


fullIndexPageExample :: Html
fullIndexPageExample = H.docTypeHtml $ do
  H.html ! A.lang "en" $ do
    H.head $ do
      H.meta ! A.charset "utf-8"
      H.meta ! A.name "viewport" ! A.content "width=device-width, initial-scale=1"
      H.title "Pretty Simple Language"
      H.link ! A.rel "stylesheet" ! A.href "/assets/css/main.css"
    
    H.body $ do
      -- Wrapper
      H.div ! A.id "wrapper" $ do
        H.header ! A.id "header" $ do
          H.h1 $ H.a ! A.href "#" $ ">Pretty Simple Language"
          
          H.nav ! A.class_ "links" $
            H.ul $ do
              H.li $ H.a ! A.href "#" $ "Lorem"
              H.li $ H.a ! A.href "#" $ "Ipsum"
              H.li $ H.a ! A.href "#" $ "Feugiat"
              H.li $ H.a ! A.href "#" $ "Tempus"
              H.li $ H.a ! A.href "#" $ "Adipiscing"

          H.nav ! A.class_ "main" $
            H.ul $ do
              H.li ! A.class_ "search" $ do
                H.a ! A.class_ "fa-search" ! A.href "#search" $ "Search"
                H.form ! A.id "search" ! A.method "get" ! A.action "#" $ 
                  H.input ! A.type_ "text" ! A.name "query" ! A.placeholder "Search" 
              H.li ! A.class_ "menu" $
                H.a ! A.class_ "fa-bars" ! A.href "#menu" $ "Menu"

        -- Menu
        H.section ! A.id "menu" $ do
          H.section $ do
            H.form ! A.class_ "search" ! A.method "get" ! A.action "#" $
              H.input ! A.type_ "text" ! A.name "query" ! A.placeholder "Search"
          
          -- Links
          H.section $ H.ul ! A.class_ "links" $ do
            H.li $ H.a ! A.href "#" $ do
              H.h3 "Lorem ipsum"
              H.p "Feugiat tempus veroeros dolor"
            H.li $ H.a ! A.href "#" $ do
              H.h3 "Dolor sit amet"
              H.p "Sed vitae justo condimentum"
            H.li $ H.a ! A.href "#" $ do
              H.h3 "Feugiat veroeros"
              H.p "Phasellus sed ultricies mi congue"
            H.li $ H.a ! A.href "#" $ do
              H.h3 "Etiam sed consequat"
              H.p "Porta lectus amet ultricies"

          -- Actions
          H.section $
            H.ul ! A.class_ "actions vertical" $
              H.li $ H.a ! A.href "#" ! A.class_ "button big fit" $ "Log In"


        -- Main
        H.div ! A.id "main" $ do
          let oneArticle =
                H.article ! A.class_ "post" $ do
                  H.header $ do
                    H.div ! A.class_ "title" $ do
                      H.h2 $ H.a ! A.href "#" $ "Magna sed adipiscing"
                      H.p "Lorem ipsum dolor amet nullam consequat etiam feugiat"
                    H.div ! A.class_ "meta" $ do
                      H.time ! A.class_ "published" ! A.datetime "2015-11-01" $ "November 17, 2024"
                      H.a ! A.href "#" ! A.class_ "author" $ do
                        H.span ! A.class_ "name" $ "Jane Doe"
                        H.img ! A.src "/images/avatar.jpg" ! A.alt ""
                  H.a ! A.href "#" ! A.class_ "image featured" $ H.img ! A.src "/images/pic01.jpg" ! A.alt ""
                  H.p "Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at. Phasellus sed ultricies mi non congue ullam corper. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla."
                  H.footer $ do
                    H.ul ! A.class_ "actions" $ 
                      H.li $ H.a ! A.href "#" ! A.class_ "button big" $ "Continue Reading"
                    H.ul ! A.class_ "stats" $ do 
                      H.li ! A.href "#" $ "General"
                      H.li ! A.href "#" ! A.class_ "icon fa-heart" $ "28"
                      H.li ! A.href "#" ! A.class_ "icon fa-comment" $ "128"
          sequence_ (replicate 3 oneArticle :: [Html])

          -- Pagination
          H.ul ! A.class_ "actions pagination" $ do
            H.li $ H.a ! A.href "" ! A.class_ "disabled button big previous" $ "Previous Page"
            H.li $ H.a ! A.href "#" ! A.class_ "button big next" $ "Next Page"


        -- Sidebar
        H.section ! A.id "sidebar" $ do
          -- Intro
          H.section ! A.id "intro" $ do
            H.a ! A.href "#" ! A.class_ "logo" $ H.img ! A.src "/images/logo.jpg" ! A.alt ""
            H.header $ do
              H.h2 "Future Imperfect"
              H.p $ do
                "Another fine responsive site template by" 
                H.a ! A.href "http://html5up.net" $ "HTML5 UP"
          
          -- Mini Posts
          H.section $ do
            H.div ! A.class_ "mini-posts" $ do
              let onePost = 
                    H.article ! A.class_ "mini-post" $ do
                      H.header $ do
                        H.h3 $ H.a ! A.href "#" $ "Vitae sed condimentum"
                        H.time ! A.class_ "published" ! A.datetime "2015-10-20" $ "October 20, 2015"
                        H.a ! A.href "#" ! A.class_ "author" $ H.img ! A.src "/images/avatar.jpg" ! A.alt ""
                      H.a ! A.href "#" ! A.class_ "image" $ H.img ! A.src "images/pic04.jpg" ! A.alt ""
              sequence_ (replicate 4 onePost :: [Html])

          -- Posts List
          H.section $ do
            H.ul ! A.class_ "posts" $ do
              let oneMiniPost = 
                    H.li $ H.article $ do
                      H.header $ do
                        H.h3 $ H.a ! A.href "#" $ "Lorem ipsum fermentum ut nisl vitae"
                        H.time ! A.class_ "published" ! A.datetime "2015-10-20" $ "October 20, 2015"
                      H.a ! A.href "#" ! A.class_ "image" $ H.img ! A.src "/images/pic08.jpg" ! A.alt ""
              sequence_ (replicate 5 oneMiniPost :: [Html])

          -- About
          H.section ! A.class_ "blurb" $ do
            H.h2 "About"
            H.p "Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod amet placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at phasellus sed ultricies."
            H.ul ! A.class_ "actions" $ do
              H.li ! A.href "#" ! A.class_ "button" $ "Learn More"

          -- Footer
          H.section ! A.id "footer" $ do
            H.ul ! A.class_ "icons" $ do
              H.li $ H.a ! A.href "#" ! A.class_ "fa-twitter" $ H.span ! A.class_ "label" $ "Twitter"
              H.li $ H.a ! A.href "#" ! A.class_ "fa-facebook" $ H.span ! A.class_ "label" $ "Facebook"
              H.li $ H.a ! A.href "#" ! A.class_ "fa-instagram" $ H.span ! A.class_ "label" $ "Instagram"
              H.li $ H.a ! A.href "#" ! A.class_ "fa-rss" $ H.span ! A.class_ "label" $ "RSS"
              H.li $ H.a ! A.href "#" ! A.class_ "fa-envelope" $ H.span ! A.class_ "label" $ "Email"
            H.p ! A.class_ "copyright" $ do 
              "© Untitled. Design: "
              H.a ! A.href "http://html5up.net" $ "HTML5 UP"
              ". Images: " 
              H.a ! A.href "http://unsplash.com" $ "Unsplash"
              "."



      H.script ! A.src "/assets/js/jquery.min.js" ! A.type_ "text/javascript" $ mempty
      H.script ! A.src "/assets/js/skel.min.js" ! A.type_ "text/javascript" $ mempty
      H.script ! A.src "/assets/js/util.js" ! A.type_ "text/javascript" $ mempty
      H.script ! A.src "/assets/js/main.js" ! A.type_ "text/javascript" $ mempty

    pure ()