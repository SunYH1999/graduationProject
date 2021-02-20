<template>
    <!--轮播图组件-->
    <div class="slider">
        <el-carousel indicator-position="outside" arrow="always">
            <el-carousel-item>
                <h3><img src="../assets/img/adminbg.png" alt="" style="width: 100%"></h3>
            </el-carousel-item>
            <el-carousel-item>
                <h3><img src="../assets/img/sd.jpg" alt="" style="width: 100%"></h3>
            </el-carousel-item>
            <el-carousel-item>
                <h3><img src="../assets/img/banner3.jpg" alt="" style="width: 100%"></h3>
            </el-carousel-item>
            <el-carousel-item>
                <h3><img src="../assets/img/banner2.jpg" alt="" style="width: 100%"></h3>
            </el-carousel-item>
			<el-carousel-item>
			    <h3><img src="../assets/img/yc.png" alt="" style="width: 100%"></h3>
			</el-carousel-item>
        </el-carousel>
    </div>
</template>

<script>
    export default {
        name: "slider",
        data() {
            return {

            }
        }
    }
</script>

<style scoped>

    >>> .el-carousel__container {
		width: 80%;
		margin: 0 auto;
        height: 400px;
    }
    .el-carousel__item h3 {
        color: #475669;
        font-size: 18px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }
</style>