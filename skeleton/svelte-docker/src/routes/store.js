import { writable, derived } from 'svelte/store';

/** Store for your data. 
This assumes the data you're pulling back will be an array.
If it's going to be an object, default this to an empty object.
**/
export const apiData = writable([]);

/** Data transformation.
For our use case, we only care about the drink names, not the other information.
Here, we'll create a derived store to hold the drink names.
**/
export const values = derived(apiData, ($apiData) => {
  // if ($apiData.drinks){
  //   return $apiData.drinks.map(drink => drink.strDrink);
  // }
  const keys = Object.keys($apiData);
  // keys.map((k) => {
  //   return $apiData[k];
  // });
  return keys; //$apiData;
});