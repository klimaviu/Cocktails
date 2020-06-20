Cocktails
================

# The distribution of alcoholic vs non-alcoholic drinks

The results are not surprising - most of the cocktails are alcoholic.

![](Cocktails_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

# Top 25 ingredients

I took the top 25 most common ingredients and graphed them in a circular
manner - this was inspired by @JacobHakim2 over at Twitter.

![](Cocktails_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

# Ingredients in alcoholic vs non-alcoholic drinks

I took the most common ingredients in non alcoholic drinks and then
compared their occurrence in both categories.

![](Cocktails_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

# Types of drink categories:

“Ordinary Drink” appears to be the most common category in this dataset.

![](Cocktails_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

# The most common ingredients in ordinary drinks:

Gin is the clear winner here, followed by vodka and lemon juice.

![](Cocktails_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

# Which category uses the most ingredients on average?

## A table:

| Category             | Average ingredient count |
| :------------------- | -----------------------: |
| Homemade Liqueur     |                 4.056338 |
| Punch / Party Drink  |                 3.417112 |
| Milk / Float / Shake |                 3.053333 |
| Cocoa                |                 2.926829 |
| Cocktail             |                 2.684426 |
| Ordinary Drink       |                 2.660377 |
| Other/Unknown        |                 2.508065 |
| Soft Drink / Soda    |                 2.459459 |
| Coffee / Tea         |                 2.395062 |
| Shot                 |                 2.230263 |
| Beer                 |                 1.812500 |

Looks like it is homemade liqueur.

## A graph:

![Average ingredient count by
category](Cocktails_files/figure-gfm/unnamed-chunk-9-1.png)

## Ingredients in homemade liqueur:

I wouldn’t have expected to see coffee here\!

![](Cocktails_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

# What are the top 5 most commonly recommended glass types?

If you want to have the most luck at having picked the correct glass -
go simple and use a cocktail glass.

| glass               | sum |
| :------------------ | --: |
| cocktail glass      | 449 |
| collins glass       | 413 |
| highball glass      | 377 |
| old-fashioned glass | 229 |
| shot glass          | 104 |

# Glass types and drinks:

I: - selected the top 5 glass types, - retrieved the top 10 most popular
drink types for said glasses, - mutated the drink variable to only
contain 11 levels: either one of these top drinks, or “other” - grouped
by glass and drink type and sorted by occurence in a descending order,
then took the top 20 results and - plotted everything in a bar chart

![](Cocktails_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

# Which ingredients are the most commonly used with gin?

The top 3 would be lemon juice, grenadine and dry vermouth.

![](Cocktails_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

# Which drinks have the longest names?

There are certainly some intriguing specimens here.

| Drink name                            | Length | Drink Id |
| :------------------------------------ | -----: | -------: |
| banana strawberry shake daiquiri-type |     37 |    12658 |
| ’57 chevy with a white license plate  |     36 |    14029 |
| radioactive long island iced tea      |     32 |    16984 |
| grape lemon pineapple smoothie        |     30 |    12712 |
| brandon and will’s coke float         |     29 |    16447 |
| lassi - a south indian drink          |     28 |    12690 |
| orange scented hot chocolate          |     28 |    12748 |
| owen’s grandmother’s revenge          |     28 |    13200 |
| pineapple gingerale smoothie          |     28 |    12718 |
| 3-mile long island iced tea           |     27 |    15300 |

# Let’s plot some of the more interesting cases:

Not as complicated as the names make them sound, huh?

![](Cocktails_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

# A random sample of drinks containing both gin and lemon juice:

![](Cocktails_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

# Boston cocktails

Let’s have a short glance at this dataset. What are the top ingredients
and how often do they occur in all categories but the Cocktail Classics?

![](Cocktails_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

# An apology to the Cocktail Classics for having excluded them:

Everybody likes classics, right?

![](Cocktails_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

# A random sample of drinks:

The boston cocktail data set provides a measure for each ingredient,
which is handy for anyone wanting to test the drink recipes.

![](Cocktails_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->