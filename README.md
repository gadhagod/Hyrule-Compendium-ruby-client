<p align="center">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/1024px-Ruby_logo.svg.png" length=10% width=10%>
</p>

<h1 align="center"> Hyrule Compendium API Ruby Wrapper</h1>
<p align="center"><b>The official Ruby wrapper for the <a href="https://github.com/Hyrule-Compendium-API/Hyrule-Compendium-API">Hyrule Compendium API</a>.</b></p>

***
WE ARE CURRENTLY LOOKING FOR MAINTAINERS FOR THIS PACKAGE. PLEASE EMAIL [gadhagod@gmail.com](mailto:gadhagod@gmail.com) IF YOU ARE INTERESTED.
***

It's recommended that you read the [API documentation](https://github.com/Hyrule-Compendium-API/Hyrule-Compendium-API/blob/master/README.md) before getting started.

## Installation

    gem install Hyrule-Compendium

## Usage

    require 'hyrule_compendium'  # import library
    compendium = Hyrule_Compendium.new  # create class instance

    compendium.get_entry 1  # get entry with ID
    compendium.get_entry "horse"  # get entry with name

    compendium.get_category "monsters"  # get category

    compendium.get_all  # get everthing

    compendium.download_entry_image "lynel", "lynel.png"

Detailed docs in code comments.
