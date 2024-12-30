import * as THREE from 'three';

// canvas
const canvas = document.querySelector('canvas.webgl');

// mouse
const mouse = {
    x: 0,
    y: 0,
}

const scroll = {
    y : 0
}

// scene
const scene = new THREE.Scene();

const size = {
    width : window.innerWidth,
    height : window.innerHeight,
}

// camera
const camera = new THREE.PerspectiveCamera(75, size.width / size.height, 0.1, 50);
camera.position.z = 5;

// geometry
const geometry = new THREE.IcosahedronGeometry(1, 30);

// materail
const sphereColor = new THREE.Color().setHSL(0.5, 1, 0.5);
const material = new THREE.MeshStandardMaterial({
    color : sphereColor,
    roughness : 0.5,
    metalness : 0.5,
    wireframe: true,
});

const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);

// light
const light = new THREE.DirectionalLight(0xffffff, 1);
light.position.set(1, 1, 1);
scene.add(light);

const lightMoving = (mx, my) => {
    light.position.x = mx;
    light.position.y = my;
}

// renderer
const renderer = new THREE.WebGLRenderer({
    canvas : canvas,
    antialias : true,
})

renderer.setSize(size.width, size.height);

const updateSize = () => {
    size.width = window.innerWidth;
    size.height = window.innerHeight;
    camera.aspect = size.width / size.height;
    camera.updateProjectionMatrix();
    renderer.setSize(size.width, size.height);
}


// events
window.addEventListener('resize', updateSize);
window.addEventListener('mousemove', (event) => {
    mouse.x = event.clientX / size.width;
    mouse.y = -(event.clientY / size.height);
});
window.addEventListener('wheel', (event) => {
    scroll.y = event.deltaY * 0.01;
});


const animate = () => {
    requestAnimationFrame(animate);
    lightMoving(mouse.x, mouse.y);

    scene.background = new THREE.Color().setHSL(scroll.y, 1, scroll.y);
    mesh.position.y = scroll.y;

    renderer.render(scene, camera);
}

animate();
