open Webapi.Dom


let project (name, goal, achieved, action) =
  let e = document |> Document.createElement "tr" in
  let e_name = document |> Document.createElement "td"
  and e_goal = document |> Document.createElement "td"
  and e_achieved = document |> Document.createElement "td"
  and e_action = document |> Document.createElement "td" in
  Element.setTextContent e_name name;
  Element.setTextContent e_goal goal;
  Element.setTextContent e_achieved achieved;
  Element.setTextContent e_action action;
  List.iter (fun c -> Element.appendChild c e)
    [e_name; e_goal; e_achieved; e_action];
  e

let unwrap = function
  | Some(v) -> v
  | None -> raise (Invalid_argument "unwrap received None")

let init () =
  let e =
    document
    |> Document.querySelector "#projects tbody"
    |> unwrap in
  [("first", "1000", "80", "start")
  ;("second", "700", "0", "start")
  ;("third", "5500", "2800", "stop")]
  |> List.map project
  |> List.iter (fun c -> Element.appendChild c e)

let () =
  Js.log "Hello, BuckleScript and Reason!";
  Window.setOnLoad window init

