# Hyrule Compendium API Ruby Wrapper

The official Ruby wrapper for the [Hyrule Compendium API](https://github.com/Hyrule-Compendium-API/Hyrule-Compendium-API). \
It's recommended that you read the [API documentation](https://github.com/Hyrule-Compendium-API/Hyrule-Compendium-API/blob/master/README.md) before getting started.

## Installation

    gem install Hyrule-Compendium

## Usage

Include the library with `require 'hyrule_compendium'.

#### `get_entry`
**Description**: Get a specific item from the hyrule compendium.
**Parameters**:

* __entry__: Entry name of ID, str or int

**Example**: `Hyrule_Compendium.get_entry 'silver lynel'`

#### `get_category`

**Description**: Get a specific category from the hyrule compendium.
**Parameters**: 

* __category__: Name of the cateogry, can be creatures, equipment, materials, monsters, or treasure

**Example**: `Hyrule_Compendium.get_category 'equipment'`

#### `get_all`
**Description**: Get all data.
**Example**: `Hyrule_Compendium.get_all`