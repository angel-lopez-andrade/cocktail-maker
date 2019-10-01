require "httparty"
require "json"

#import ingredient list JSON
initial_ingredient_list = HTTParty.get("https://the-cocktail-db.p.rapidapi.com/list.php?i=list", {
    headers: {
        "x-rapidapi-key" => "11d996c91fmsh3fb139fdb2000efp1ff9a2jsn11072f8d2aae",
        "x-rapidapi-host" => "the-cocktail-db.p.rapidapi.com"
    },
    body: {}
})
drink_ingredients = JSON.parse(initial_ingredient_list.body)
drink_ingredients = drink_ingredients["drinks"]

#import cocktail (Nigerian) name JSON
cocktail_name = HTTParty.get("https://random-nigerian-names.p.rapidapi.com/generic/getaname", {
    headers: {
        "x-rapidapi-key" => "11d996c91fmsh3fb139fdb2000efp1ff9a2jsn11072f8d2aae",
        "x-rapidapi-host" => "random-nigerian-names.p.rapidapi.com"
    },
    body: {}
})
cocktail_name = JSON.parse(cocktail_name.body)

#define cocktail making method
def make_cocktail(drink_ingredients, ingredient_num, cocktail_name)
    puts "Are you sure you'd like a cocktail with #{ingredient_num} ingredients?"
    input = gets.chomp
    case input.downcase
    when "yes"
        added_drinks = []
        ingredient_num.times do
            added_drinks.push(drink_ingredients[rand(drink_ingredients.length)]["strIngredient1"])
        end
        serve = "Your cocktail contains"
        it = 0
        while it < added_drinks.length
            if it == added_drinks.length - 1
                serve << " #{added_drinks[it].capitalize}."
                break
            end
            serve << " #{added_drinks[it].capitalize},"
            it += 1
        end
        puts serve
        puts "What a brilliant cocktail! I proclaim this cocktail - #{cocktail_name}!"
    when "no"
        puts "OK, see you next time."
    end
end

#body to guide user to cocktail making method
puts "How many ingredients do you want in your cocktail (between 2 and 10)?"
ingredient_num = gets.chomp.to_i
while ingredient_num < 2 or ingredient_num > 10
    puts "Please type in a number between 2 and 10."
    ingredient_num = gets.chomp.to_i
end
make_cocktail(drink_ingredients, ingredient_num, cocktail_name)