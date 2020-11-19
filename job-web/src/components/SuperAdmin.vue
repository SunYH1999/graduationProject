<template>
    <div class="SuperAdmin">
        <img class="adminBg" src="../assets/img/adminbg.png" alt="">
        <div class="welcome">
            <p>欢迎您</p>
            <p>超级管理员</p>

        </div>
    </div>
</template>

<script>
    export default {
        name: "SuperAdmin"
    }
</script>

<style lang="stylus" scoped>
    .SuperAdmin
        position relative
        .welcome
            width 500px
            height 300px
            position absolute
            top 0
            right 0
            bottom: 0
            left: 100px
            margin auto
            font-size 40px
            color white
    .adminBg
        width 100%

</style>