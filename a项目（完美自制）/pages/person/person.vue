<template>
  <view>
    <view class="person-head">
      <cmd-avatar src="../../static/ico/user.png" @click="fnInfoWin" size="lg" :make="{'background-color': '#fff'}"></cmd-avatar>
      <view class="person-head-box">
        <view class="person-head-nickname">水军</view>
        <view class="person-head-username">ID：12306</view>
      </view>
    </view>
    <view class="person-list">
      <cmd-cell-item title="我的设备" slot-left arrow>
        <cmd-icon type="bullet-list" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
      <cmd-cell-item title="消息通知" slot-left arrow>
        <cmd-icon type="message" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
      <cmd-cell-item title="系统设置" slot-left arrow>
        <cmd-icon type="settings" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
  
	  <cmd-cell-item title="其他网站" addon="试试" slot-left arrow v-on:click="chang">
	    <cmd-icon type="alert-circle" size="24" color="#368dff"></cmd-icon>
	  </cmd-cell-item>
    </view>
  </view>
</template>

<script>

  import cmdAvatar from "@/components/cmd-avatar/cmd-avatar.vue"
  import cmdIcon from "@/components/cmd-icon/cmd-icon.vue"
  import cmdCellItem from "@/components/cmd-cell-item/cmd-cell-item.vue"
	
  export default {
    components: {
      cmdAvatar,
      cmdCellItem,
      cmdIcon
    },
    data() {
      return {};
    },
    methods: {
      /**
       * 打开用户信息页
       */
	  chang(){
		 uni.navigateTo({
		   url:  '../about/about'
		 }) 
	  },
      fnInfoWin() {
        uni.navigateTo({
          url: '/pages/user/info/info'
        })
      }
    }
  }
</script>

<style>
	page,view{
		display: block;
	}
		@import url("../../common/uni/uni.css");
  .person-head {
    display: flex;
    flex-direction: row;
    align-items: center;
    height: 150px;
    padding-left: 20px;
    background: linear-gradient(to right, #365fff, #36bbff);
  }

  .person-head-box {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    margin-left: 10px;
  }

  .person-head-nickname {
    font-size: 18px;
    font-weight: 500;
    color: #fff;
  }

  .person-head-username {
    font-size: 14px;
    font-weight: 500;
    color: #fff;
  }

  .person-list {
    line-height: 0;
  }
</style>
