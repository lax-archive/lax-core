import LaxCore

/-!
What the attribute accepts: a `def` whose type is literally `Prop`, closed
(parameters inside with `∀`), universe-polymorphic or not, with any body.
-/

universe u

namespace Examples.Positive

/-- A closed claim. -/
@[lax_statement] def InfinitelyManyNaturals : Prop := ∀ n : Nat, ∃ m, n < m

/-- Parameters go inside with `∀`. -/
@[lax_statement] def AddComm : Prop := ∀ a b : Nat, a + b = b + a

/-- Universe parameters are allowed. -/
@[lax_statement] def InhabitedNonempty : Prop := ∀ (α : Type u) [Inhabited α], ∃ _ : α, True

/-- `Sort 0` is `Prop`. -/
@[lax_statement] def Trivial : Sort 0 := True

/-- An implication between statements is a statement like any other. -/
@[lax_statement] def CommImpliesNaturals : Prop := AddComm → InfinitelyManyNaturals

/-- A `Prop`-valued definition without the marker is an ordinary auxiliary. -/
def Auxiliary : Prop := True

-- The tag is readable from the environment.
run_meta do
  let env ← Lean.getEnv
  unless LaxCore.isLaxStatement env ``AddComm do throwError "AddComm is not tagged"
  if LaxCore.isLaxStatement env ``Auxiliary then throwError "Auxiliary is tagged"

end Examples.Positive
