<template>
  <div class="wrap">
    <div class="main container background">
      <p class="title" m-if="item.url === undefined">{{item.title}}</p>
      <p class="title" m-if="item.url !== undefined"><a href="{{item.url}}" class="no-decoration" rel="noopener">{{item.title}}</a> <span class="url light">({{base(item.url)}})</span></p>
      <p class="meta light">{{item.score}} points by <router-link to="/users/{{item.by}}" class="light">{{item.by}}</router-link> {{time(store, item.time)}}</p>
    </div>
    <div class="container background" m-if="item.descendants !== 0">
      <h6 class="comments">{{item.descendants}} comments</h6>
      <comment m-for="comment in item.kids" m-literal:comment="comment"></comment>
    </div>
  </div>
</template>

<style scoped>
  .main {
    margin-bottom: 3rem;
  }

  .container.background {
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    padding: 3rem;
  }

  .title {
    display: flex;
    align-items: center;
  }

  .title a {
    font-size: 2.5rem;
  }

  .url {
    margin-left: 1rem;
    font-size: 1.6rem;
  }

  .comments {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 2rem;
  }
</style>

<script>
  var store = require("../store/store.js").store;
  var base = require("../util/base.js");
  var time = require("../util/time.js");

  exports = {
    props: ["route"],
    data: function() {
      return {
        item: {
          title: "-",
          score: 0,
          by: "-",
          time: 0,
          url: undefined,
          descendants: 0,
          kids: []
        }
      }
    },
    methods: {
      base: base,
      time: time
    },
    hooks: {
      mounted: function() {
        var store = this.get("store");
        store.dispatch("GET_ITEM", {
          id: this.get("route").params.id,
          instance: this
        });
      }
    },
    store: store
  };
</script>