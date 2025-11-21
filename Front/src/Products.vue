<script>
export default {
  data() {
    return {
      products: [
        {'id': 1, 'name': 'Produit A', 'unit_price': 10, 'quantity': 5, 'description': '<b>genial</b>'},
        {'id': 2, 'name': 'Produit B', 'unit_price': 140, 'quantity': 4, 'description': '<b style="color: green;">On valide</b>'},
        {'id': 3, 'name': 'Produit C', 'unit_price': 15, 'quantity': 5, 'description': null},
        {'id': 4, 'name': 'Produit D', 'unit_price': 12, 'quantity': 8, 'description': 'sans commentaire'},
        {'id': 5, 'name': 'Produit E', 'unit_price': 4, 'quantity': 5, 'description': '<b>ok</b>'},
        {'id': 6, 'name': 'Produit F', 'unit_price': 160, 'quantity': 6, 'description': '<b>cool</b>'},
        {'id': 7, 'name': 'Produit G', 'unit_price': 105, 'quantity': 5, 'description': '<b>bof</b>'},
        {'id': 8, 'name': 'Produit H', 'unit_price': 50, 'quantity': 8, 'description': '<b>incroyable</b>'},
        {'id': 9, 'name': 'Produit I', 'unit_price': 40, 'quantity': 5, 'description': '<b>super</b>'},
        {'id': 10, 'name': 'Produit J', 'unit_price': 80, 'quantity': 5, 'description': '<u>génial</u>'},
      ]
    }
  },
}
</script>

<template>
  <div>
    <h1 class="text-xl p-4 text-center uppercase mb-4 bg-sky-300 text-sky-800">Nos produits</h1>
    <div class="container mx-auto flex flex-wrap" v-if="products.length > 0">
      <div class="bg-white mx-2 my-4 rounded shadow" v-for="product in products" :key="product.id">
        <h3 class="text-xl text-center bg-sky-200 text-sky-500">{{ product.name }}</h3>
        <img :src="'https://picsum.photos/140/100?random='+product.id" class="w-full card-img-top" alt="..."/>
        <div class="py-2 px-4">
          <p class="text-sm">
            <b>Prix unitaire:</b> {{ product.unit_price }} €<br>
            <b>Quantité:</b> {{ product.quantity }} en stock
          </p>
          <div class="text-sm" v-html="product.description">
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      <p>Il n'y a pas encore de produits !</p>
    </div>
  </div>
</template>

<style scoped>

</style>
