scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:modules = [
\	"Scroll",
\	"CursorMove",
\	"Delete",
\	"HistAdd",
\	"History",
\	"Cancel",
\	"Execute",
\	"NoInsert",
\	"InsertRegister",
\	"Redraw",
\]


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Cmdline  = s:V.import("Over.Commandline")
	let s:base.variables.modules = s:Signals.make()
	function! s:base.variables.modules.get_slot(val)
		return a:val.slot.module
	endfunction
endfunction


function! s:_vital_depends()
	return [
\		"Over.Commandline",
\	] + map(copy(s:modules), "'Over.Commandline.Modules.' . v:val")
endfunction


function! s:standard(...)
	let result = call(s:Cmdline.make, a:000, s:Cmdline)
	call result.connect("Execute")
	call result.connect("Cancel")
	call result.connect("Delete")
	call result.connect("CursorMove")
	call result.connect("HistAdd")
	call result.connect("History")
	call result.connect("InsertRegister")
	call result.connect(s:Cmdline.get_module("NoInsert").make_special_chars())
	call result.connect("Redraw")
	return result
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
