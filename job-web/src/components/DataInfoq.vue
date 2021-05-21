<template>
	<!-- <div id="roomTypeCheckIn"></div> -->
	<button>
		<a href="http://127.0.0.1:8848/job-web/estsjmoban/qiuzhi.html">点击查看求职数据</a>
	</button>
	
</template>

<script>
	import { Chart } from "@antv/g2";
	export default {
		data() {
		    return {
		      mydata: [
		        { roomTypeName: "单人间", checkInValue: 654, checkInPercent: 0.02 },
		        { roomTypeName: "双人间", checkInValue: 654, checkInPercent: 0.02 },
		        { roomTypeName: "钟点房", checkInValue: 4400, checkInPercent: 0.2 },
		        { roomTypeName: "海景房", checkInValue: 5300, checkInPercent: 0.24 },
		        { roomTypeName: "主题房", checkInValue: 6200, checkInPercent: 0.28 },
		        { roomTypeName: "家庭房", checkInValue: 3300, checkInPercent: 0.14 },
		        { roomTypeName: "总统房", checkInValue: 1500, checkInPercent: 0.06 }
		      ]
		    };
		  },
		  
		  methods: {
			  getData() {
			        roomTypeApi.getRoomTypeStatistics().then(res => {
			          this.mydata = res.data.data
			        })
			      },
		      initComponent() {
		        const chart = new Chart({
		          container: "roomTypeCheckIn",
		          autoFit: true,
		          height: 500,
		          padding: [50, 20, 50, 20]
		        });
		        chart.data(this.mydata);
		        chart.scale("checkInValue", {
		          alias: "销售额"
		        });
		  
		        chart.axis("roomTypeName", {
		          tickLine: {
		            alignTick: false
		          }
		        });
		        chart.axis("checkInValue", false);
		  
		        chart.tooltip({
		          showMarkers: false
		        });
		        chart
		          .interval()
		          .position("roomTypeName*checkInValue")
		          .color("roomTypeName");
		        chart.interaction("element-active");
		  
		        // 添加文本标注
		        this.mydata.forEach(item => {
		          chart
		            .annotation()
		            .text({
		              position: [item.roomTypeName, item.checkInValue],
		              content: item.checkInValue,
		              style: {
		                textAlign: "center"
		              },
		              offsetY: -30
		            })
		            .text({
		              position: [item.roomTypeName, item.checkInValue],
		              content: (item.checkInPercent * 100).toFixed(0) + "%",
		              style: {
		                textAlign: "center"
		              },
		              offsetY: -12
		            });
		        });
		        chart.render();
		      }
		    },
			
			
		   mounted() {
		      this.initComponent();
		    },
			created() {
			      this.getData()
			  },
			
			
			watch: {
			    mydata(b,a) {
			        this.chart.changeData(b)
			        this.chart.render()
			    }
			  },
		  


	}
</script>

<style>
</style>
