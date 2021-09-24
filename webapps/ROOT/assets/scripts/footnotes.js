const findNodeByText = (text) => {
  const nodes = [];
  const filter = {
    acceptNode: function (node) {
      if (node.innerText && node.innerText.includes(text)) {
        return NodeFilter.FILTER_ACCEPT;
      }

      return NodeFilter.FILTER_REJECT;
    },
  };

  const walker = document.createTreeWalker(
    document.getElementsByTagName("main")[0],
    NodeFilter.SHOW_ALL,
    filter
  );

  while (walker.nextNode()) {
    //give me the element containing the node
    nodes.push(walker.currentNode);
  }

  if (nodes.length > 0) {
    return nodes[nodes.length - 1];
  }

  return null;
};

const footNotePointerTemplate = (footnote, match) => `<div class="tooltip">
          <a href="#${footnote.id}" id="${footnote.id}-ref">${match}</a>
          <span class="tooltiptext">${footnote.innerHTML}</span>
        </div>
      `;

// Pickup all footnotes, add id to those which have the correct format of text inside.
// Format is [.*] -> e.g. [1], [2], [fish], [orange], etc.
function initFootnotes() {
  const initializedFootnotes = [];

  const footnotes = document
    .getElementById("footnotes")
    .getElementsByTagName("p");

  for (let footnote of footnotes) {
    const match = footnote.innerHTML.match(/(?<footnote>\[.*?\])/);

    if (match) {
      const fNote = match.groups.footnote;

      footnote.id = "footnote-" + fNote.replace("[", "").replace("]", "");

      footnote.innerHTML = footnote.innerHTML.replace(
        fNote,
        fNote.replace("[", "").replace("]", "")
      );

      initializedFootnotes.push({ node: footnote, match: fNote });
    }
  }

  initializedFootnotes.forEach((footnote) => {
    const footnotePointerContainer = findNodeByText(footnote.match);

    if (footnotePointerContainer) {
      footnotePointerContainer.innerHTML =
        footnotePointerContainer.innerHTML.replace(
          footnote.match,
          footNotePointerTemplate(footnote.node, footnote.match)
        );

      const refLink = document.createElement("a");
      refLink.classList.add("back-to-ref");
      refLink.href = "#" + footnote.node.id + "-ref";
      refLink.appendChild(document.createTextNode("^"));
      footnote.node.prepend(refLink);
    }
  });
}

initFootnotes();
