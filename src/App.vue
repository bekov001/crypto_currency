<template>
    <div class="order">
        <p><strong>Баланс: </strong> {{ this.balance }}$</p>
        <p>Заполнить по кол-ву</p>
        <div style="display: flex; flex-direction: row;">
        <input style="width: 100%" type="number">
        <p style="margin-left: 10px;">BTC</p>
        </div>
        <button class="btn btn-success" id="long" @click="createLong">Long</button>
        <button class="btn btn-danger" id="short" @click="createShort">Short</button>
    </div>
    <h1 style="margin: 15px;">Позиции</h1>
    <h4 v-if="positions.length == 0" style="margin: 15px; color: red">у вас нет позиций</h4>
    <position-list :positions="positions" @close="closePos"/>
</template>

<script>
    import PositionList from './components/PositionList.vue';
    import axios from 'axios';
    export default{
        components : {
            PositionList
        },
        data(){
            return {
            balance: 100,
            positions: [],
            price: '28000'
        }},
        
 
    methods: {
            createLong(){
                if (this.balance > 0){
                    this.positions.push({
                    id: Date.now(),
                    start_price: this.price,
                    balance: this.balance,
                    type_of_pos: "long"

                })
                this.balance = 0;
                } else {
                    alert("Недостаточно средств")
                }
                // localStorage.positions = this.positions
                
            },
            createShort(){
                if (this.balance > 0){
                    this.positions.push({
                    id: Date.now(),
                    start_price: this.price,
                    balance: this.balance,
                    type_of_pos: "short"

                })
                this.balance = 0;
                } else {
                    alert("Недостаточно средств")
                }
                // localStorage.positions = this.positions
                
            },
            closePos(position) {
                var pnl = (((position.start_price - this.price) / this.price) * 100 * position.balance).toFixed(2);
                if (position.type_of_pos == 'long'){
                    pnl = (((this.price - position.start_price) / position.start_price) * 100 * position.balance).toFixed(2)
                }
                this.balance = (parseFloat(position.balance) + parseFloat(pnl)).toFixed(2);
                this.positions = this.positions.filter(p => p.id != position.id);

                // localStorage.balance = this.balance
            },
            async fetchPrice() {
                try {
                            const response = await axios.get("https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT");
                            // console.log(response);
                            this.price = response.data.price.slice(0, 8);
                    }
                catch(e) {
                        alert("error")
            }},
        },

    mounted(){
    //     if (localStorage.positions) {
    //     this.positions = localStorage.positions;
    // }
    // if (localStorage.balance) {
    //     this.balance = localStorage.balance;
    // }
        this.fetchPrice();
        this.timer = setInterval(this.fetchPrice, 1000);
   },
}
  
</script>

<style>
@import '~bootstrap/dist/css/bootstrap.css';

.order {
    margin: 10px;
    padding: 10px;
    display: flex;
    flex-direction: column;
}

#long {
    margin-top: 15px;
}

#short {
    margin-top: 15px;
}

</style>