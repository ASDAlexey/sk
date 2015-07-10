HTMLCollection.prototype.forEach=Array.prototype.forEach;
NodeList.prototype.forEach=Array.prototype.forEach;
HTMLElement.prototype.index=function(){
    var self=this,
        parent=self.parentNode,
        i=0;
    while(self.previousElementSibling){
        i++;
        self=self.previousElementSibling
    }
    return this===parent.children[i]?i:-1;
};
// проверяем поддержку
if(!Element.prototype.matches){
    // определяем свойство
    Element.prototype.matches=Element.prototype.matchesSelector||
        Element.prototype.webkitMatchesSelector||
        Element.prototype.mozMatchesSelector||
        Element.prototype.msMatchesSelector
}
if(!Element.prototype.closest){

    // реализуем
    Element.prototype.closest=function(css){
        var node=this;

        while(node){
            if(node.matches(css)) return node;
            else node=node.parentElement;
        }
        return null;
    };
}