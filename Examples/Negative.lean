import LaxCore

/-!
What the attribute rejects, each with the message the hook gives. Every
failure is `#guard_msgs`-checked, so `lake build` passes exactly when the
messages are the documented ones.
-/

namespace Examples.Negative

/--
error: invalid `@[lax_statement]` on `Examples.Negative.NotADef`: a statement is a `def`, not a `theorem`: a theorem proves, a statement claims
-/
#guard_msgs in
@[lax_statement] theorem NotADef : True := trivial

/--
error: invalid `@[lax_statement]` on `Examples.Negative.NotADefEither`: a statement is a `def`, not an `axiom`: nothing in a spec-2 archive declares axioms
-/
#guard_msgs in
@[lax_statement] axiom NotADefEither : Prop

/--
error: invalid `@[lax_statement]` on `Examples.Negative.Opaque`: a statement is a `def`, not an `opaque` constant
-/
#guard_msgs in
@[lax_statement] opaque Opaque : Prop

/--
error: invalid `@[lax_statement]` on `Examples.Negative.Ind`: a statement is a `def`; this declaration is not a definition
-/
#guard_msgs in
@[lax_statement] inductive Ind : Prop where | mk

/--
error: invalid `@[lax_statement]` on `Examples.Negative.WithBinder`: a statement takes no binders and is not a function: quantify inside the body with `∀`, as in `def X : Prop := ∀ n, …`
-/
#guard_msgs in
@[lax_statement] def WithBinder (n : Nat) : Prop := n = n

/--
error: invalid `@[lax_statement]` on `Examples.Negative.Predicate`: a statement takes no binders and is not a function: quantify inside the body with `∀`, as in `def X : Prop := ∀ n, …`
-/
#guard_msgs in
@[lax_statement] def Predicate : Nat → Prop := fun n => n = n

/--
error: invalid `@[lax_statement]` on `Examples.Negative.NotAProp`: a statement's type must be literally `Prop` (`Sort 0`), not a term that merely reduces to it; this declaration has type
  Nat
-/
#guard_msgs in
@[lax_statement] def NotAProp : Nat := 0

/--
error: invalid `@[lax_statement]` on `Examples.Negative.TypeValued`: a statement's type must be literally `Prop` (`Sort 0`), not a term that merely reduces to it; this declaration has type
  Type
-/
#guard_msgs in
@[lax_statement] def TypeValued : Type := Nat

/--
error: invalid `@[lax_statement]` on `Examples.Negative.ReducesToProp`: a statement's type must be literally `Prop` (`Sort 0`), not a term that merely reduces to it; this declaration has type
  id Prop
-/
#guard_msgs in
@[lax_statement] def ReducesToProp : id Prop := True

/--
error: invalid `@[lax_statement]` on `Examples.Negative.Hidden`: a statement cannot be `private`; the archive reads statements by name
-/
#guard_msgs in
@[lax_statement] private def Hidden : Prop := True

end Examples.Negative
