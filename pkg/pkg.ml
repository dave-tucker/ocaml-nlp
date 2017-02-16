#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "nlp" @@ fun c ->
  Ok [ Pkg.mllib "src/nlp.mllib";]
