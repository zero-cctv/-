<template>
    <view class="page">
        <view class="feedback-body" >
            <textarea placeholder="请输入..." style="border-bottom:1px solid   #F1F1F3;" v-model="sendDate.content" class="feedback-textare" />
        </view>
		<tmupload :isImg="isImg" :upload_auto="upload_auto" ref="tmupload"  v-if="refesh"></tmupload>

        <view class="swiper-list">
            <view class="uni-list-cell uni-list-cell-pd feedback-title">
                <view class="uni-list-cell-db " v-if="isImg">图片</view>
				<view class="uni-list-cell-db " v-else>视频</view>
                <switch :checked="isImg" @change="changeIndicatorDots" />
            </view>
        </view>

        <button type="default" class="feedback-submit" @tap="send">提交</button>

    </view>
</template>

<script>
	import tmupload from "../../components/publish_Plus/tm-upload/tm-upload.vue"
    export default {
        name:'newsPublish',
        components:{
			tmupload
        },
        data() {
            return {
				upload_auto:false,
                isImg:true,
                count:6,
                maxwh:280,
                quality:1, 
                uid:"",				
				refesh:true,
                msgContents: ["界面显示错乱", "启动缓慢，卡出翔了", "UI无法直视，丑哭了", "偶发性崩溃"],
                stars: [1, 2, 3, 4, 5],
                imgList: [],
                sendDate: {
                    score: 0,
                    content: "",
                    contact: ""
                }
            }
        },
        onShow() {
			 uni.startPullDownRefresh({});
			 // console.log(this.uid);
			this.uid=this.$getStorage("uid").toString();
			// console.log(this.uid);
        },
		onPullDownRefresh() {
		       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
		       console.log('refresh');
			   this.uid=this.$getStorage("uid").toString();
			  
		       setTimeout(function () {
		           uni.stopPullDownRefresh();  //停止下拉刷新动画
		       }, 500);
		   },
        methods: {
			getData(surl, str,p) {
					uni.request({
						url: surl,
						method: 'GET',
						data: p,
						success: res => {
							console.log('发送网址:' + surl);
							this.data = res;
							
						},
						fail: () => {
							console.log('this is fail');
						},
						complete: () => {
							this.requestafter(str);
						}
					});
				
			},
            compressImg(e){
              console.log(e)  
            },
            changeIndicatorDots(e){
            this.isImg = !this.isImg
            },
            fileChange(e){
              this.imgList=e;
                  //             YCImg.canvasToBase64(e)
                  // .then(e => {
                  //     // console.log(JSON.stringify(e))
                  //     this.value = e;
                  //     this.confirm();
                  //     // console.log(e)
                  // })
                  // .catch(e => {
                  //     uni.showToast({
                  //         title: '失败！' + e.message,
                  //         icon: 'none',
                  //         duration: 1000
                  //     });
                  // })
            },
            chooseStar(e) { //点击评星
                this.sendDate.score = e;
            },
            previewImage() { //预览图片
                uni.previewImage({
                    urls: this.imgList
                });
            },
			/**动态传递参数给子组件,
			1,父组件调用子组件方法;
			2,在子组件里使用watch观察父组件传递过来的参数是否改变
			
			*/
            send() { //发送提交    
				// this.url="http://127.0.0.10:1080/Home/File/upload";
					
				this.requestafter("sendimg");
            },
			requestafter(str) {
				if(str=="sendimg"){					
					this.url=this.$api.user.upload;
					this.upload_auto=true;				
					this.$refs.tmupload.changurl(this.url);
					this.$refs.tmupload.upload(this.upload_auto);
					this.upload_auto=false;			
					uni.showToast({
						icon: 'none',
						position: 'bottom',
						title: '发送成功'
					})
				}
			}
        }
    }
</script>

<style>
	@import url("../../common/publish_css/uni.css");
    page {
        background-color: #EFEFF4;
    }

    .input-view {
        font-size: 28upx;
    }
    .close-view{
        text-align: center;line-height:14px;height: 16px;width: 16px;border-radius: 50%;background: #FF5053;color: #FFFFFF;position: absolute;top: -6px;right: -4px;font-size: 12px;
    }
</style>
