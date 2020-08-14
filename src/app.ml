open Webapi.Dom


let project name =
  document |> Document.createElement "tr"

let unwrap = function
  | Some(v) -> v
  | None -> raise (Invalid_argument "unwrap received None")

let init () =
  document
  |> Document.querySelector "#projects tbody"
  |> unwrap
  |> Element.appendChild (project "first")

let () =
  Js.log "Hello, BuckleScript and Reason!";
  Window.setOnLoad window init

