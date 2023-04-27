<template>
    
    <div class="positions" v-for="position in positions" :key="position">
        <div class="position">
            <p>BTCUSDT ({{ position.type_of_pos }})</p>
            <p>Кросс 100x</p>
            <!-- <p>Нереализованный pnl {{ ((position.start_price - this.price) / this.price) * 100 * position.balance}}</p> -->
            <p v-if="position.type_of_pos === 'long'">Нереализованный pnl {{ (((this.price - position.start_price) / position.start_price) * 100 * position.balance).toFixed(2)}}$</p>
            <p v-else>Нереализованный pnl {{ (((position.start_price - this.price) / this.price) * 100 * position.balance).toFixed(2)}}$</p>
            <div style="display:flex; flex-direction: row; justify-content: space-between;">
                <p style="margin-right: 15px;">Цена входа: {{ position.start_price }}</p>
                
                <P style="margin-right: 15px;">Маржа: {{ position.balance }}$</P>
                <P style="margin-right: 15px;">Рыночная цена: {{ this.price }}</P>
            </div>
        
            <button class="btn btn-secondary" style="width: 100%" @click="$emit('close', position)">Закрыть</button>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

    export default {
        data(){
            return {
            price: '28000'
        }},
        props: {
            positions: {
                type: Array,
                required: true
            }
        },
        methods: {
        async fetchPrice() {
                try {
                            const response = await axios.get("https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT");
                            // console.log(response);
                            this.price = response.data.price.slice(0, 8);
                    }
                catch(e) {
                        alert("error")
            }}},
        mounted(){
        this.fetchPrice();
        this.timer = setInterval(this.fetchPrice, 1000);
   },
    }
</script>

<style scoped>
.positions {
    background-color: antiquewhite;
    margin: 10px;
}
.position {
    padding: 10px;
}
</style>