
async function getBase64Image(src, removeImageBackGround, callback, outputFormat) {
	const img = new Image();
	img.crossOrigin = 'Anonymous';
	img.addEventListener("load", () => loadFunc(), false);
	async function loadFunc() {
	  const canvas = document.createElement('canvas');
	  const ctx = canvas.getContext('2d');
	  if (removeImageBackGround) {
		  var SelectedSize = 320
		  canvas.height = SelectedSize;
		  canvas.width = SelectedSize;
		  ctx.drawImage(img, 0, 0, SelectedSize, SelectedSize);
		  await removebackground(canvas);
	  } else {
		  canvas.height = img.naturalHeight;
		  canvas.width = img.naturalWidth;
		  ctx.drawImage(img, 0, 0);
	  }
	  let dataURL = canvas.toDataURL(outputFormat);
	  callback(dataURL);
	};
  
	img.src = src;
	if (img.complete || img.complete === undefined) {
	  img.src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAkCAIAAACIS8SLAAAAKklEQVRIie3NMQEAAAgDILV/55nBww8K0Enq2XwHDofD4XA4HA6Hw+E4Wwq6A0U+bfCEAAAAAElFTkSuQmCC";
	  img.src = src;
	}
}

async function Convert(pMugShotTxd, removeImageBackGround, id) {
	let tempUrl = 'https://nui-img/' + pMugShotTxd + '/' + pMugShotTxd + '?t=' + String(Math.round(new Date().getTime() / 1000));
	if (pMugShotTxd == 'none') {
		tempUrl = 'https://cdn.discordapp.com/attachments/555420890444070912/983953950652903434/unknown.png';   
	}
	getBase64Image(tempUrl, removeImageBackGround, function(dataUrl) {
		$.post(`https://${GetParentResourceName()}/Answer`, JSON.stringify({
			Answer: dataUrl,
			Id: id,
		}));
	})
}

// https://www.youtube.com/watch?v=GV6LSAYzEgc
async function removebackground(SentCanvas) {
	const canvas = SentCanvas;
	const ctx = canvas.getContext('2d');
	
	// Loading the model
	const net = await bodyPix.load({
	architecture: 'MobileNetV1',
	outputStride: 16,
	multiplier: 0.75,
	quantBytes: 2
	});
	
	// Segmentation
	const { data:map } = await net.segmentPerson(canvas, {
	internalResolution: 'medium',
	});
	
	
	// Extracting image data
	const { data:imgData } = ctx.getImageData(0, 0, canvas.width, canvas.height);
	
	// Creating new image data
	const newImg = ctx.createImageData(canvas.width, canvas.height);
	const newImgData = newImg.data;
	
	for(let i=0; i<map.length; i++) {
	//The data array stores four values for each pixel
	const [r, g, b, a] = [imgData[i*4], imgData[i*4+1], imgData[i*4+2], imgData[i*4+3]];
	[
		newImgData[i*4],
		newImgData[i*4+1],
		newImgData[i*4+2],
		newImgData[i*4+3]
	] = !map[i] ? [255, 255, 255, 0] : [r, g, b, a];
	}
	
	
	// Draw the new image back to canvas
	ctx.putImageData(newImg, 0, 0);
}

window.addEventListener("message", (e) => GotMessage(e), false);
async function GotMessage(e) {
	let msg = e.data
	if (msg.type == 'convert') {
		Convert(msg.pMugShotTxd, msg.removeImageBackGround, msg.id);
	}
}

