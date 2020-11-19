<template>
    <div class="wantJob">
        <Slider />
        <Position />
    </div>
</template>

<script>
    import Slider from '@/components/Slider.vue'
    import Position from '@/components/Position.vue'
    export default {
        name: "want-job",
        components: {
            Slider,
            Position
        }
    }
</script>

<style scoped>

</style>