# Intel Module Generation Guide (for LLMs)

Generic instructions for generating **Intel Module** text content for *Zorns Mission Utility Mod* (MUM). This file is setting-agnostic — combine it with a separate campaign/setting document for tone, period, and world-specific details.

---

## 1. Your Task

When asked to generate intel:
1. Pick the module type that best fits the narrative beat (see §2).
2. Fill in **every required field** of that module's template (see §3) with complete, ready-to-use text.
3. Match tone/period/world details to whatever campaign setting document is provided alongside this guide.
4. Output the filled template directly — plain, copy-pasteable text only. No JSON, no code, no extra formatting around it.

## 2. Choosing a Module Type

| Use this module...   | ...when the intel is                                                                                                        |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Basic**            | Any generic written item that doesn't fit the other categories (documents, ledgers, orders, lists)                          |
| **eMail**            | A digital email-style message                                                                                               |
| **Handwritten Note** | A short personal note, warning, or instruction meant to look hand-scrawled                                                  |
| **Phone Message**    | A back-and-forth text/pager/chat conversation between two parties                                                           |
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
Handrwitten Note:
```
- **Handrwitten Note** – the handwritten text itself (field name is spelled this way in the mod's code)

### Phone Message
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
