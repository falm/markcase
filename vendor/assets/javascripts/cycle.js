function init() {
    (function ($) {
        if (!Array.prototype.reduce) {
            Array.prototype.reduce = function reduce(accumulator) {
                if (this === null || this === undefined) throw new TypeError("Object is null or undefined");
                var i = 0,
                    l = this.length >> 0,
                    curr;

                if (typeof accumulator !== "function") // ES5 : "If IsCallable(callbackfn) is false, throw a TypeError exception."
                throw new TypeError("First argument is not callable");

                if (arguments.length < 2) {
                    if (l === 0) throw new TypeError("Array length is 0 and no second argument");
                    curr = this[0];
                    i = 1; // start accumulating at the second element
                } else curr = arguments[1];

                while (i < l) {
                    if (i in this) curr = accumulator.call(undefined, curr, this[i], i, this);
                    ++i;
                }

                return curr;
            };
        }
        $.fn.cycle = function () {
            var args = Array.prototype.slice.call(arguments).reduce(function (p, c, i, a) {
                if (i == 0) {
                    p.functions = c;
                } else if (typeof c == "function") {
                    p.callback = c;
                } else if (typeof c == "string") {
                    p.events = c;
                }
                return p;
            }, {});
            args.events = args.events || "click";
            console.log(args);
            if (args.functions) {
                var currIndex = 0;

                function toggler(e) {
                    e.preventDefault();
                    var evaluation = args.functions[(currIndex++) % args.functions.length].apply(this);
                    if (args.callback) {
                        callback(currIndex, evaluation);
                    }
                    return evaluation;
                }
                return this.on(args.events, toggler);
            } else {
                //throw "Improper arguments to method \"alternate\"; no array provided";
            }
        };
    })(jQuery);
}
