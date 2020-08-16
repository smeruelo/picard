open Webapi.Dom

type project = {
  name: string;
  goal: int;
  achieved: int
}

module Decode = struct
  let project json =
    {
      name = Json.Decode.(field "Name" string json);
      goal = Json.Decode.(field "Goal" int json);
      achieved = Json.Decode.(field "Achieved" int json)
    }

  let project_list json =
    Json.Decode.(list project json)
end

let project (name, goal, achieved, action) =
  let e = Document.createElement "tr" document
  and e_name = Document.createElement "td" document
  and e_goal = Document.createElement "td" document
  and e_achieved = Document.createElement "td" document
  and e_action = Document.createElement "td" document in
  Element.setTextContent e_name name;
  Element.setTextContent e_goal goal;
  Element.setTextContent e_achieved achieved;
  Element.setTextContent e_action action;
  List.iter (fun c -> Element.appendChild c e) [e_name; e_goal; e_achieved; e_action];
  e

let unwrap = function
  | Some(v) -> v
  | None -> raise (Invalid_argument "unwrap received None")

let update_projects json =
  let e =
    Document.querySelector "#projects tbody" document
    |> unwrap in
  Decode.project_list json
  |> List.map (fun p -> project (p.name, (string_of_int p.goal), (string_of_int p.achieved), "Stop"))
  |> List.iter (fun c -> Element.appendChild c e)

let init () =
  Js.Promise.(
    Fetch.fetch "/projects"
    |> then_ Fetch.Response.json
    |> then_ (fun json -> update_projects json |> resolve)
    |> catch (fun err -> Js.log err |> resolve)
    |> ignore
  )

let () =
  Js.log "Hello, BuckleScript and Reason!";
  Window.setOnLoad window init

