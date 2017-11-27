part of server;

class TextData {
  List phrases;
  TextData() {
    phrases = _textData.split('\n\n');
  }

  Map getRandomPhrase() {
    Random random = new Random();
    String phrase = phrases[random.nextInt(phrases.length)];
    int val = phrase.split('.').length;
    return {
      'text' : phrase,
      'value' : val * 2
    };
  }

  static final _textData = '''I once tried to eat a rock.

Ain’t nobody got time for this.

It’s simple, if it jiggles, it’s fat.

Racecar backwards is racecaR.

Try to be a rainbow in someone’s cloud.

You may not think it be like it is, but it do.

These are not the droids you’re looking for.

*Supercalifragilisticexpialidocious.

I never said most of the things I said.

If two wrongs don’t make a right, try three.

I can resist everything except temptation.

My fake plants died because I did not pretend to water them.

Laugh and the world laughs with you, snore and you sleep alone.

Drawing on my fine command of the English language, I said nothing.

A woman’s mind is cleaner than a man’s: she changes it more often.

Alright everybody, line up alphabetically according to height.

I may be drunk, Miss, but in the morning I will be sober and you will still be ugly.

I can't change the direction of the wind, but I can adjust my sails to always reach my destination

Everyone sleeps differently. For example, I sleep on my side, my friend sleeps on his back, and my ex sleeps around.

What concert costs only 45 cents? 50 cent featuring Nickelback.

My friend David had his ID stolen, so now we just call him Dav.

Nineteen and twenty had a fight. 21.

In my view, the Jedi are evil. Well then you are lost!

Having thus begun, I can now be quite at ease, and should even. According to the notions of religious morality existing among contemporary people, be beyond all doubt assured that everything further in this new venture of mine will now proceed, as is said, “Like a pianola.”

Now this is a story all about how my life got flip-turned upside down I’d like to take a moment just sit right there i’ll tell you how i became the prince with a dick in my butt.

Billy trips over a blue, leather couch before reaching his crunchy chocolate bar. Then, he gets up and finally holds on to the delicious chocolate. He then eats it.

You hear about pluto? That’s messed up.

what if one day you woke up and your nipples were gone

Well my first gay experience goes like this: I stepped on a Corn Flake; now i’m a Cereal Killer

Llama poop is sellable.

If you fart consistently for six years and nine months, enough gas is produced to create the energy of an atomic bomb.

Another one.

Atheism is a non-prophet organization.

Don’t hold your farts in, because they’ll travel up to your brain and that’s where all the crappy ideas come from.

If Mary had baby Jesus, and baby Jesus was the Lamb of God… Did Mary have a little lamb?

If no one comes from the future to stop you from doing it then how bad of a decision can it be?

Anything you say can and will be held against you so only say my name.

Fire trucks are red because there's eight wheels on them and four people, and four plus eight is twelve, and twelve is a foot and a foot is a ruler, and Queen Elizabeth was a ruler, and Queen Elizabeth was also a ship, and the ship sails the sea and in the sea is fish and fish have fins, and the Finns fought the Russians and the Russians were red and that's why firetrucks are red.

The five most reassuring words you can hear: “I haven’t started yet either.”

Boom clap the sound of my thighs this pizzas so good nom nom nom nom nom nom

“What’re you up to?” His simple text said. “Just eating cereal and lying in bed.” “What if I was with you?” he responded with ease, “I guess I’d get more cereal if I please.” And that’s when he said it, that simpering lad, that stupid response that makes us all mad. My mind filled with dread, with a twist in my gut, I picked up my phone and read: “Haha, and then what ;)”

Gus, don't be an incorrigible Eskimo pie with a caramel ribbon.

The dot used in lowercase "i" and "j" is called a tittle.

One time a girl kissed me on a school bus without warning and told me that I could get off at her stop and we could walk to her house because her parents weren’t home. I said no because I was going to miss Dragon Ball Z.

I hate when old people poke you at a wedding and say "you're next". So next time I was at a funeral I poked them and said "you're next".

Bikinis and tampons were invented by men.

The worst time to have a heart attack is during a game of charades.

When I die, I want to go peacefully like my grandfather did -- in his sleep. Not yelling and screaming like the passengers in his car.

The scientific theory I like best is that the rings of Saturn are composed entirely of lost airline luggage.

I love deadlines. I like the whooshing sound they make as they fly by.

The only mystery in life is why the kamikaze pilots wore helmets.

The people who make lyric videos on youtube are the backbone of this nation.

Sometimes I look at people and wonder how they’ve made it this far.

Glass is transparent because glass is made from sand, and sand can be fine or coarse, and 5 course meals cost two hundred dollars, and you can buy half a smartphone with two hundred dollars, but since nobody only wants half a phone, they go to work to make more money on top of the two hundred, and if communism was their type of government, it wouldn’t matter what job they had, and communism lacks transparency, and since glass isn’t communism, glass is transparent.

“Off the wall.” Vans. Vans off the wall. Vans are also cars. Who drives vans? Creeps. Who’s creepy? Slenderman. Slenderman wears a suit, so Natalia Kills would disapprove. “Natalia Kills” has three A’s in it. A triangle has three sides. This post is illuminati confirmed.

Tables can be white because tables are a piece of furniture, and you put furniture inside of a house. Houses are more expensive in the city. Cities have rich people in them. Rich people have a lot of money. Rich people also have profitable companies. Apple is a profitable company. Apple’s wires are white. And that’s why tables are white.

 None of the babies in “Rugrats” actually exist, but they are all instead figments of Angelica’s imagination, as a result of her parent’s negligence. Chuckie died with his mother, which explains how much of a nervous wreck his father is. Tommy was a stillborn baby, which explains why his father, Stu, was always in the basement making toys for the son he never had. Finally, the DeVilles had an abortion. To compensate for not knowing the sex of the baby, Angelica invented twins in her head. One boy, one girl.''';
}