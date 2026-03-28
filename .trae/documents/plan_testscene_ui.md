# Plan: Redesign UI to "Clean Glassmorphism"

## Summary
The user requested a truly unique and visually appealing UI without changing the fundamental layout. They have selected the "Clean Glassmorphism" style. We will completely overhaul the `StyleBoxFlat` resources in `TestScene.tscn` to use semi-transparent backgrounds with soft gradients, subtle white frosted borders, soft blurred drop shadows, and modern typography styling.

## Current State Analysis
- The UI currently uses solid dark grey panels (`Color(0.17, 0.17, 0.17)`) with solid neon green borders.
- It lacks modern visual flair, looking very flat and somewhat dated.
- The layout is structured using `PanelContainer`s which cleanly inherit `StyleBox`es.
- There is a background noise texture (`TextureRect`) that can serve nicely behind glass panels.

## Proposed Changes
We will update all the `SubResource("StyleBoxFlat_...")` definitions in `Scenes/TestScene.tscn` to achieve the glassmorphism look:

1. **Main Panels (`StyleBoxFlat_panel`)**:
   - **Background**: Semi-transparent dark/cool grey (e.g., `Color(0.1, 0.12, 0.15, 0.6)`).
   - **Border**: Very thin (1px or 2px), semi-transparent white/blue (e.g., `Color(1, 1, 1, 0.15)`) to simulate the frosted glass edge catching light.
   - **Corners**: Increased radius for a smoother modern look (e.g., `16px`).
   - **Shadow**: Large, very soft, and low-opacity shadow to float the glass over the background (`shadow_size = 20`, `shadow_color = Color(0, 0, 0, 0.3)`).

2. **Navigation Buttons (`StyleBoxFlat_0r02p`, `_btn_hover`, `_btn_pressed`)**:
   - **Normal**: Almost completely transparent background (`Color(1, 1, 1, 0.03)`), no borders, rounded corners (8px).
   - **Hover**: Slightly more opaque white background (`Color(1, 1, 1, 0.1)`), perhaps a subtle left-border accent using the original green `Color(0.3, 1, 0.33, 0.8)` to show selection.
   - **Pressed**: Slightly darker background (`Color(0, 0, 0, 0.2)`), inner shadow or pushed down feel.

3. **Calendar Buttons (`StyleBoxFlat_cal_...`)**:
   - **Normal**: Transparent background (`Color(1, 1, 1, 0.05)`), subtle 1px border (`Color(1, 1, 1, 0.05)`).
   - **Hover**: Brighten background (`Color(1, 1, 1, 0.15)`), brighten border (`Color(1, 1, 1, 0.3)`).
   - **Pressed**: Darken background (`Color(0, 0, 0, 0.3)`).

4. **Typography / Labels**:
   - Remove the heavy black drop shadow from the previous iteration if present, or soften it drastically. Glassmorphism relies on clean, airy text.

## Assumptions & Decisions
- Godot 4 `StyleBoxFlat` does not natively support true background blurring (blurring what is behind the UI element) without a dedicated shader. However, we can heavily imply glassmorphism by using semi-transparent `bg_color`, soft white borders, and drop shadows over the existing noise texture background.
- We will do this by carefully replacing the SubResource blocks in the `.tscn` file via a Node.js script.

## Verification Steps
- Parse the `.tscn` to ensure syntax is valid.
- Open the scene in Godot and confirm the semi-transparent glass effect looks cohesive and modern.
