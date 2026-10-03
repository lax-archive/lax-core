# LaxCore

The one Lean module every spec-2 [Lax](https://laxarchive.org) environment
pins beside mathlib. It declares the `lax_statement` tag attribute that marks
a definition as a *statement* of a Lax concept package — an endpoint of an
edge in the archive's proof network:

```lean
import LaxCore

@[lax_statement] def InfinitelyManyPrimes : Prop := ∀ n, ∃ p, n < p ∧ p.Prime
```

A statement is a `def` whose type is literally `Prop`, with no binders
(parameters go inside with `∀`), not `private`; universe parameters are
allowed. The attribute's validation hook rejects anything else at the
author's elaboration with a message naming the rule. `Examples/Positive.lean`
shows what is accepted; `Examples/Negative.lean` holds every rejection as a
`#guard_msgs`-checked expected failure, so `lake build` passes exactly when
the messages are the documented ones.

The archive's validator re-judges every rule from the inspector's facts and
never trusts this hook: `LaxCore` is a convenience for the author and a marker
for the reader, not a gate. The inspector reads the tagged names as data from
each module's olean, without running this module's initializer: they are the
entries (of type `Name`) of the persistent extension named after the
`initialize` declaration, `LaxCore.laxStatementAttr`. **That declaration name
is interface** — the archive reads it by name, so it stays exactly
`initialize laxStatementAttr : TagAttribute ← registerTagAttribute `lax_statement …`
inside `namespace LaxCore`, never `private`. The file is header-less
(`import Lean`, no `module` header), as every spec-2 package is: a `module`
file cannot import a header-less library, while a header-less file can
import anything.

## Pinning

Every spec-2 environment of the archive pins this repository **by commit**,
in the environment table of the `lax` CLI (`src/submission-validation/environments.ts`
in [lax-archive/lax](https://github.com/lax-archive/lax)), beside the
environment's mathlib commit. A submission requires it directly at exactly
that commit:

```toml
[[require]]
name = "LaxCore"
git = "https://github.com/lax-archive/lax-core"
rev = "<the commit the environment pins>"
```

The module imports only `Lean`, so one commit serves every toolchain it
builds under. It is deliberately tiny: it is part of the archive's trust
base, reviewed and frozen with the environment that pins it.

## Building

`lake build` under the toolchain in `lean-toolchain` (install
[elan](https://github.com/leanprover/elan) and it picks the toolchain up).
CI does exactly that.
