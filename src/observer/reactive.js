/**
 * Makes an Object Reactive
 * @param {Object} instance
 * @param {Object} obj
 */
var reactiveObject = function(instance, obj) {
  for(var key in obj) {
    reactiveProp(instance, obj, key, obj[key]);
  }
  return obj;
}

/**
 * Makes an Object Property Reactive
 * @param {Object} instance
 * @param {Object} obj
 * @param {String} key
 * @param {Any} val
 */
var reactiveProp = function(instance, obj, key, val) {
  // Prop is object, make this reactive
  if(val !== null && typeof val === 'object') {
    reactiveObject(instance, val);
  }
  Object.defineProperty(obj, key, {
    get: function() {
      return val;
    },
    set: function(newVal) {
      val = newVal;
      instance.$observer.notify();
    }
  });
}
