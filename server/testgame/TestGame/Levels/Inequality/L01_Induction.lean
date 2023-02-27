import TestGame.Metadata

Game "TestGame"
World "Inequality"
Level 1

Title "Induktion"

set_option tactic.hygienic false

Introduction
"
Hier lernst du Induktion und Ungleichungen kennen. Beides essenziele Grundlagen, die du
für spätere Aufgaben brauchst.

Die Leantaktik `induction n` führt einen Induktionsbeweis über `(n : ℕ)`. Hier zuerst
ein abstraktes Beispiel.
"

Statement
"Sei $P(n)$ eine logische Aussage über die natürliche Zahl.
Agenommen $P(0)$ ist wahr und $P(m) \\Rightarrow P(m+1)$ für alle $m$,
dann gilt $P(n)$ für alle $n \\in \\mathbb{N}.$"
    (n : ℕ) (P : ℕ → Prop) (h_base : P 0) (h_step : ∀ m, P m → P m.succ) : P n := by
  induction n
  assumption
  apply h_step
  assumption

-- TODO: Why are these not shown.
HiddenHint (n : ℕ) (P : ℕ → Prop) : P n =>
"Benutze `induction n`."

Hint (P : ℕ → Prop) : P 0 =>
"Das ist die Induktionsverankerung, hier musst du $P(0)$ zeigen."

Hint (P : ℕ → Prop) (m : ℕ) (hi : P m) : P (Nat.succ m) =>
"An der Stelle kommt der Beweis $P(m) \\Rightarrow P(m+1)$.

In diesem Beispiel kannst du `apply` benützen."

NewTactics induction
