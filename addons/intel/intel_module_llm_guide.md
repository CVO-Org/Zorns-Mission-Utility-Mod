# Intel Module Generation Guide (for LLMs)

Generic instructions for generating **Intel Module** text content for *Zorns Mission Utility Mod* (MUM). This file is setting-agnostic — combine it with a separate campaign/setting document for tone, period, and world-specific details.

---

## 1. Your Task

When asked to generate intel:
1. Pick the module type that best fits the narrative beat (see §2).
2. Fill in **every required field** of that module's template (see §3) with complete, ready-to-use text.
3. Match tone/period/world details to whatever campaign setting document is provided alongside this guide.
4. Output the filled template directly — plain, copy-pasteable text only. No JSON, no code, no extra formatting around it.

Only convert the intel into script code when the user explicitly asks for it (see §5).

## 2. Choosing a Module Type

| Use this module...   | ...when the intel is                                                                                                        |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Basic**            | Any generic written item that doesn't fit the other categories (documents, ledgers, orders, lists)                          |
| **eMail**            | A digital email-style message                                                                                               |
| **Handwritten Note** | A short personal note, warning, or instruction meant to look hand-scrawled                                                  |
| **Messages**         | A back-and-forth text/pager/chat conversation between two parties                                                           |
| **Photo**            | Rarely used — do not generate this module unless explicitly asked; a human handles the photo and its backside note manually |

## 3. Module Templates

Fill in every field. Use `<br/>` for line breaks within multi-line fields.

### Basic
```
Intel Group:
Intel Title:
Description:
Intel Content:
```
- **Intel Group** – groups related intel items, e.g. by location or topic
- **Intel Title** – title of this piece of intel
- **Description** – short narrative line shown when the item is discovered
- **Intel Content** – the actual intel text

### eMail
```
Intel Group:
Intel Title:
Description:
eMail Date:
eMail Sender:
eMail Recipient:
eMail Subject:
eMail Text:
```
- **eMail Date** – free text, no fixed format required
- **eMail Sender / Recipient** – addresses or names
- **eMail Subject** – subject line
- **eMail Text** – body of the email

### Handwritten Note
```
Intel Group:
Intel Title:
Description:
Handwritten Note:
```
- **Handwritten Note** – the handwritten text itself

### Messages
```
Intel Group:
Intel Title:
Description:
Message Sender:
Message Meta:
1. Type (SENDER/RECIPIENT/NONE):
1. Text:
2. Type:
2. Text:
3. Type:
3. Text:
4. Type:
4. Text:
5. Type:
5. Text:
6. Type:
6. Text:
```
- **Message Sender** – name of the chat partner (defaults to "Unknown" if left empty)
- **Message Meta** – subtitle under the chat partner's name (defaults to "Last Activity: Unknown" if left empty)
- **N. Type** – SENDER, RECIPIENT, or NONE for that slot
- **N. Text** – content of that slot
- Unused slots: Type = NONE, Text left empty

### Photo *(rare — only on explicit request)*
```
Intel Group:
Intel Title:
Description:
Backside:
```

## 4. General Rules

- Treat all fields (except the omitted Photo image fields) as **required** — always fill them in.
- Default "Description" examples baked into the mod's own code are a loose tone guideline only, not mandatory phrasing.
- Prefer partial, ambiguous, or biased information over neat exposition dumps — intel should feel found, not authored for the player's convenience.
- Tie content back to concrete elements already established in the active campaign setting (place names, character descriptions, faction names) rather than inventing unrelated new lore, unless asked to invent something new.
- Keep the **Description** free of exact placement details (e.g. "tucked under a sandbag"). The mission maker may place the object differently in the editor, and the text must not contradict what players see. Describe the item itself instead (e.g. "A crumpled, rain-soaked note").

## 5. Optional: Export as Script

Only do this when the user explicitly asks for it (e.g. "export as script", "convert to function calls"). Never export on your own, and never in the same answer as a first draft — the user reviews the templates first.

### What to convert

- Convert the templates **as they currently stand in the conversation**, including any versions the user edited and pasted back. Copy the field values exactly — do not rewrite, shorten, or improve them.
- If the user told you about changes in the editor (e.g. "the laptop is now on a shelf in the bunker"), use them for the placement line.
- **Photo** intel is not exported as code. List it in the checklist only, marked `(set up manually with the Photo module)`.

### Output structure

1. One `sqf` code block, meant for the mission's `initServer.sqf`. One function call per intel item, each with a comment block above it (same text as its checklist entry).
2. Below the code block, the checklist titled `Variable names to assign in Eden:`, one entry per intel item, separated by blank lines.

### Function per module type

Fields are passed in the order of the template in §3. Do not pass any further (optional) arguments — the defaults of the modules apply.

| Module           | Function call                                                                                                                    |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Basic            | `[object, "Group", "Title", "Description", "Content"] call MUM_intel_fnc_createIntelBasic;`                                       |
| eMail            | `[object, "Group", "Title", "Description", "Date", "Sender", "Recipient", "Subject", "Text"] call MUM_intel_fnc_createIntelEmail;` |
| Handwritten Note | `[object, "Group", "Title", "Description", "Note"] call MUM_intel_fnc_createIntelHandwrittenNote;`                                |
| Messages         | `[object, "Group", "Title", "Description", "Sender", "Meta", [["SENDER", "Text"], ["RECIPIENT", "Text"]]] call MUM_intel_fnc_createIntelMessages;` |

- **Messages**: list only the used slots, in order, as `["SENDER", "..."]` or `["RECIPIENT", "..."]`. Drop slots with type NONE.
- Write each call over several lines, one argument per line, so it is easy to read.

### Variable names

- Pattern: `intel_<location>_<item>`, e.g. `intel_depot_ledger`.
- Lowercase letters, digits and underscores only, starting with a letter. Unique within the export.
- The object argument of the call is this variable name, without quotes.

### String rules

- Every text value is in double quotes `"..."`.
- A double quote **inside** a text must be written twice: `""`. Example: `"Crates 23-25 marked ""lost in transit""."`
- Keep `<br/>` for line breaks. Do not put real line breaks inside a string.
- Do not use `&`, `<` or `>` in the text, other than in `<br/>`. Write "and" instead of `&`.

### Checklist entry

```
VariableName - Object - Location
Placement: Where exactly the object goes within the location, plus a few fitting props around it.
What the item is and what it reveals. How it connects to other intel or where it leads the players.
```

- **Line 1**: variable name, the physical object (Ledger, Laptop, Paper, Phone, ...), and the location.
- **Placement**: a suggestion only — the mission maker may change it. Keep the scene simple and use only props that typically exist in Arma 3 (desks, tables, crates, sandbags, vehicles, bodies, ...).
- **Context**: at most two sentences. This is a note for the mission maker, not for players, so it may name connections between intel items openly.

### Example

````
```sqf
// intel_depot_ledger - Ledger - Puesto Crow depot
// Placement: On a cluttered desk in the depot office, among empty coffee cups and loose paperwork.
// Water-stained supply ledger with several pages torn out. Shows crates 23-25 marked "lost in transit", the first hint that supplies are being diverted.
[
    intel_depot_ledger,
    "Puesto Crow",
    "Supply Ledger",
    "A water-stained ledger, several pages torn out.",
    "Crates 14-22: delivered.<br/>Crates 23-25: ""lost in transit"" - ask R."
] call MUM_intel_fnc_createIntelBasic;

// intel_courier_phone - Phone - River crossing
// Placement: On the courier's body near the riverbank, next to an overturned motorbike.
// Pager with a chat to handler R. They arrange a handover at the old mill, which points players toward the next location.
[
    intel_courier_phone,
    "River Crossing",
    "Courier's Pager",
    "The screen is cracked, but still readable.",
    "R.",
    "Last Activity: 2 hours ago",
    [
        ["SENDER", "Package ready?"],
        ["RECIPIENT", "Yes. Same place as last time?"],
        ["SENDER", "Old mill. Midnight. Come alone."]
    ]
] call MUM_intel_fnc_createIntelMessages;
```

Variable names to assign in Eden:

intel_depot_ledger - Ledger - Puesto Crow depot
Placement: On a cluttered desk in the depot office, among empty coffee cups and loose paperwork.
Water-stained supply ledger with several pages torn out. Shows crates 23-25 marked "lost in transit", the first hint that supplies are being diverted.

intel_courier_phone - Phone - River crossing
Placement: On the courier's body near the riverbank, next to an overturned motorbike.
Pager with a chat to handler R. They arrange a handover at the old mill, which points players toward the next location.
````
