var Notlr = function() {
  // Private Functions
  //
  function bindNotlrBehaviors() { 

    // Make all notes appear nicely and make a button for each hidden note
    $$('.note.hidden').each(function(el){ makeHiddenNote(el); }); 
    $$('.note.normal').each(function(el){ el.appear(); }); 

    // Make all notes actions div hidden
    $$('.note_actions').each( function(el){ el.fade(); });

    // Make hovering a note appear that note's actions div
    $$('.note').each(function(el) { 
      Notlr.bindNoteBehaviors(el);
    });

    // The trash bin that archives the Notes. Gotta find the way to avoid
    // calling updateNote after the onDrop callback
    Droppables.add('trash', {
      accept: 'note',
      onDrop: function(dragelement, dropelement, ev){
        note_id = dragelement.id.replace(/note_/, ""); 
        Notlr.deleteNote(note_id);
      }, 
      onHover: function(dragelement, dropelement, ev){
      },
    });

  }

  function makeHiddenNote(el) {

    el.fade({ duration:0.2 });
    note_id = el.id;
    note_title = el.down('.note_title').innerHTML;

    // Create the new hidden note and insert it on the hidden_notes container
    hidden_note = new Element('li', {class: 'hidden_note', id: 'hidden_note_' + note_id}).update(note_title);
    $('hidden_notes').insert(hidden_note, {position:top}); 

    // Show note and update status after clicking a hidden note
    hidden_note.observe('click', function(e){
      el.appear();
      this.remove();
      Notlr.updateNote(el.id.replace(/note_id/,""), {note: {status: 'normal'}});
    });

    // Bind mouse behaviors for hidden note
    hidden_note.observe('mouseover', function(e){
      this.addClassName('hover');
    });
    hidden_note.observe('mouseout', function(e){
      this.removeClassName('hover');
    });
  }

  function toRailsParams(params) {
    return Object.extend({authenticity_token: $('auth_token').value}, params);
  }

  function getNotePosition(note_id){
    noteElement = $('note_'+note_id);
    note_left = parseInt(noteElement.getStyle('left').replace(/px/, ""));
    note_top = parseInt(noteElement.getStyle('top').replace(/px/, "")); 
    return {left: note_left, top: note_top};
  }

  return {
    bindBehaviors: function(){
      bindNotlrBehaviors();
    }, 

    updateNote: function(note_id, attrs) {
      new Ajax.Request('/notes/' + note_id.replace(/note_/, ""), {
        method: 'put',
        parameters: serializer.serialize(toRailsParams(attrs)),
        onSuccess: function(transport) {
          response_json = transport.responseJSON;
          if (response_json == null) {
            alert("There was an error!");
          }
        }
      });
    },

    deleteNote: function(note_id){
      $('note_'+note_id).fade({duration: 0.3});
      new Ajax.Request('/notes/' + note_id.replace(/note_/, ""), {
        method: 'delete',
        parameters:{authenticity_token: $('auth_token').value},
        onSuccess: function() {
          $('note_'+note_id).remove();
        },
        onFailure: function() {
          alert('There was an error.');
          $('note_'+note_id).appear({duration: 0.3});
        }
      });
    },

    bindNoteBehaviors: function(el) {
      el.observe('mouseenter', function(e) { el.down('.note_actions').appear({duration: 0.2}); });
      el.observe('mouseleave', function(e) { el.down('.note_actions').fade({ duration: 0.2 }); });

      el.down('.note_actions').down('.minimize').observe('click', function(e){
        makeHiddenNote(el);
        Notlr.updateNote(el.id.replace(/note_id/,""), {note: {status: 'hidden'}});
      });

      new Draggable(el, { 
        revert: false, 
        scroll:window,
        onEnd: function(e,ev) {
          noteElement = e.element;
          note_id = e.element.id.replace(/note_/, ""); 
          position = getNotePosition(note_id);
          note = {note: position};
          Notlr.updateNote(note_id, note);
        }
      }); 

      /* This will allow editing notes, although seems a bit complex right now
       *
       *el.observe('dblclick', function() {
       *  Modalbox.show('/notes/' + el.id.replace(/note_/, "") + "/edit")
       *});
       */

      // Make hovering a link appear the href as a CoolTip
      el.select('.link').each(function(el) {
        el.title = el.href;
        new Tooltip(el, {
          mouseFollow: true,
          backgroundColor: '#ff4', 
          textColor: '#00f',
          maxWidth: 500,
          delay: 100
        });
      });

    }

  }
}();


// http://snippets.dzone.com/posts/show/2426 -- Serialize an object
// into rails hash-like parameters
var serializer = {

  serialize : function(object) {
    var values = []; 
    var prefix = '';

    values = this.recursive_serialize(object, values, prefix);

    param_string = values.join('&');
    return param_string;
  },

  recursive_serialize : function(object, values, prefix) {
    for (key in object) {
      if (typeof object[key] == 'object') {

        if (prefix.length > 0) {
          prefix += '['+key+']';         
        } else {
          prefix += key;
        }

        values = this.recursive_serialize(object[key], values, prefix);

        prefixes = prefix.split('[');

        if (prefixes.length > 1) {
          prefix = prefixes.slice(0,prefixes.length-1).join('[');
        } else {
          prefix = prefixes[0];
        }

        } else {
        value = encodeURIComponent(object[key]);
        if (prefix.length > 0) {
          prefixed_key = prefix+'['+key+']'          
          } else {
            prefixed_key = key
          }
          prefixed_key = encodeURIComponent(prefixed_key);
          if (value) values.push(prefixed_key + '=' + value);
        }
      }
      return values;
    }
  }


  Element.observe(window, 'dom:loaded', Notlr.bindBehaviors );
