function(doc) {
    if(doc['@class']=='fr.sirs.core.model.Convention'){
        for each (association in doc.associations){
           emit(association.objetId, doc);
        }
    }
}