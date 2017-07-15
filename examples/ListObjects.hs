#!/usr/bin/env stack
-- stack --resolver lts-8.5 runghc --package minio-hs

--
-- Minio Haskell SDK, (C) 2017 Minio, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

{-# Language OverloadedStrings #-}
import           Network.Minio

import qualified Data.Conduit as C
import qualified Data.Conduit.Combinators as CC
import           Prelude


-- | The following example uses minio's play server at
-- https://play.minio.io:9000.  The endpoint and associated
-- credentials are provided via the libary constant,
--
-- > minioPlayCI :: ConnectInfo
--

main :: IO ()
main = do
  let
    bucket = "test"

  -- Performs a recursive listing of all objects under bucket "test"
  -- on play.minio.io.
  res <- runMinio minioPlayCI $
    listObjects bucket Nothing True C.$$ CC.sinkList
  print res

  {-
    Following is the output of the above program on a local Minio server.

    Right [ObjectInfo {oiObject = "ADVANCED.png", oiModTime = 2017-02-10 05:33:24.816 UTC, oiETag = "\"a69f3af6bbb06fe1d42ac910ec30482f\"", oiSize = 94026},ObjectInfo {oiObject = "obj", oiModTime = 2017-02-10 08:49:26.777 UTC, oiETag = "\"715a872a253a3596652c1490081b4b6a-1\"", oiSize = 15728640}]
  -}
