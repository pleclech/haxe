open Type

type ide_type =
	| ITFunction of int * int
	| ITConstructor of int * int

type ide_def = {
	id_type : ide_type option;
}

type ide_context = {
	mutable flag:int;
}

let ideflag_none = 0
let ideflag_prop = 1
let ideflag_noreadable = 2
let ideflag_nowritable = 4

let ide_helper:ide_def option ref = ref None

let get_flag_access (is_parent:bool) (cf:tclass_field) =
	let ictx = {flag=ideflag_none;} in
	let set f = ictx.flag <- ictx.flag lor f in
	let set_access rmode = function
		| AccNever -> set(if rmode then ideflag_noreadable else ideflag_nowritable)
		| AccNo when not is_parent -> set(if rmode then ideflag_noreadable else ideflag_nowritable)
		| _ -> ()
	in
	begin match cf.cf_kind with
		| Var {v_read=AccNormal; v_write=AccNormal;} -> ()
		| Var v ->
			set(ideflag_prop);
			set_access true v.v_read;
			set_access false v.v_write
		| _ -> ()
	end;
	ictx
