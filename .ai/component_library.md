# Component Library

These components already exist in the project and MUST be reused.

Do NOT generate new widgets if one exists here.

---

# Common Widgets

Location: lib/utils/common_widgets/

## App Bars
- CommonAppBar
- CustomAppBar

Use for all screens.

---

## Buttons
- CommonButton
- CommonShortButton
- CommonGradientButton

Use instead of ElevatedButton or TextButton.

---

## Text Fields
- CommonTextFormField
- DecimalTextFormatter

Use CommonTextFormField for all input fields.

---

## Text
- CommonText

Supports:
- Rich text
- Gradient text
- Stroke text

---

## Loaders
- CommonLoader
- ShimmerProgress

Use CommonLoader for API loading states.

---

## Dropdowns
- CustomDropdownString
- CustomSearchDropdown

Use instead of DropdownButton.

---

## Images
- CommonImage

Handles network and asset images.

---

## Indicators
- Custom LinearProgressIndicator

Used for progress bars.

---

## Pickers
- DatePicker
- TimePicker
- CommonCountryPicker

---

## Decorations
Use helpers from:

lib/utils/common_decorations/

Examples:
- commonBgColorDecoration
- commonWhiteDecoration

---

## Other Widgets
- DottedLine
- RadioButton
- ToggleSwitch
- CommonTabBar
- SliverCommonTabBar


# Utility Layer

Location: lib/utils/

---

## common_constants.dart

Contains:

### Colors
CommonColors
- themeColor
- secondaryColor
- etc.

### Shared Preferences Keys
PreferenceKeys

### Spacing System
Responsive constants:

numD01
numD02
numD03
...
numD95

Used as:

size(context).width * numD04

---

## common_methods.dart

Contains helper methods:

- date formatting
- validation
- toast messages
- reusable logic helpers