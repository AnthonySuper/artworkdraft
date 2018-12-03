<template>
  <div>
    <div class="content" v-for="tag in tags" :key="tag.id">
      <removeable-tag :tagName="tag.name" :tagId="tag.id"
        v-on:remove-tag="removeTag" />
    </div>
    <div class="tag-suggestions-container">
      <div class="field has-addons">
        <div class="control">
        <input v-model="inputValue" 
               type="text" 
               class="input" 
               v-on:focus="startFocus"
               v-on:blur="endFocus"
               v-on:keydown="keydown"
               v-on:input="changeInput" />
        </div>
        <div class="control">
          <a class="button is-info" v-on:click="addCurrentTag">
            Add tag
          </a>
        </div>
      </div>
      <div class="suggestions-box"
           v-bind:class="{active: hasFocus}"
           v-for="(tag, idx) in currentSuggestions"                        
           :key="tag.id">
        <tag-suggestion :tag="tag"
          :is-active="idx == activeSuggestionIdx"
          v-on:tag-clicked="addTag"/>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["tags"],
  model: {
    prop: "tags",
    event: "change-tags",
  },
  components: {
    "removeable-tag": async function() {
      let cmp = await import('./removeable-tag.vue');
      return cmp.default;
    },
    "tag-suggestion": async function() {
      let cmp = await import("./tag-suggestion.vue");
      return cmp.default;
    }
  },
  data: function() {
    return {
      inputValue: "",
      suggestions: [],
      activeSuggestionIdx: 0,
      hasFocus: false,
    }
  },
  computed: {
    currentSuggestions() {
      let filtering = this.inputValue.toLowerCase();
      let f = s => s.name.toLowerCase().includes(filtering);
      return this.suggestions.filter(f);
    }
  },
  methods: {
    addTag: function(tag) {
      console.log("Adding tag", tag);
      let tags = [...this.tags, tag];
      this.suggestions = [];
      this.activeSuggestionIdx = 0;
      this.$emit("change-tags", tags);
    },
    addCurrentTag: function() {
      let tag = this.currentSuggestions[this.activeSuggestionIdx];
      if(tag) {
        this.addTag(tag);
      }
    },
    keydown: function(evt) {
      let key = evt.key;
      if(key == "ArrowDown") {
        this.moveActiveIdx(1);
      }
      else if(key == "ArrowUp") {
        this.moveActiveIdx(-1);
      }
      else if(key == "Enter") {
        this.addCurrentTag();
        evt.preventDefault();
      }
    },
    moveActiveIdx: function(idx) {
      this.activeSuggestionIdx += idx;
      this.activeSuggestionIdx = 
        this.activeSuggestionIdx % this.currentSuggestions.length
      if(this.activeSuggestionIdx < 0) {
        this.activeSuggestionIdx = 0;
      }
    },
    removeTag: function(tagId) {
      this.tags = this.tags.filter(t => t.id !== tagId);
    },
    changeInput: async function(event) {
      let s$ = await fetch(`/tags.json?q=${this.inputValue}`);
      let s = await s$.json();
      this.suggestions = s;
      this.activeSuggestionIdx = 0;
    },
    startFocus: function() {
      this.hasFocus = true;
    },
    endFocus: function() {
      window.setTimeout(() => this.hasFocus = false, 300);
    }
  }
}
</script>

<style>
.suggestions-box {
  display: none;
}

.suggestions-box.active {
  display: block;
}
</style>
