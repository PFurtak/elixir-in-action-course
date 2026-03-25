# Elixir in Action — Exercises

Code-along exercises for *Elixir in Action, 3rd Edition* by Saša Jurić.

## Structure

```
elixir-intro-exercises/
├── ch01_first_steps/
├── ch02_building_blocks/
├── ch03_control_flow/
├── ch04_data_abstractions/
├── ch05_concurrency_primitives/
├── ch06_generic_server_processes/
├── ch07_building_concurrent_system/
├── ch08_fault_tolerance_basics/
├── ch09_isolating_error_effects/
├── ch10_beyond_genserver/
├── ch11_working_with_components/
├── ch12_building_distributed_system/
├── ch13_running_the_system/
└── todo_system/              ← the running Mix project built across chapters 4–13
```

## Running scripts

Chapters 1–4 use standalone `.exs` scripts. Run them with:

```bash
elixir ch02_building_blocks/exercises.exs
```

Or load them in IEx for interactive exploration:

```bash
iex ch02_building_blocks/exercises.exs
```

## Running the Todo system

```bash
cd todo_system
mix deps.get
mix test
iex -S mix
```

## Book progression

| Part | Chapters | Theme |
|------|----------|-------|
| 1 | 1–4 | Functional Elixir |
| 2 | 5–10 | Concurrent Elixir |
| 3 | 11–13 | Production |
