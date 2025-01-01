import * as THREE from 'three';

// Util Class
class Utils {
    constructor(canvas, renderer, camera, scene) {
        this.canvas = canvas;
        this.renderer = renderer;
        this.camera = camera;
        this.scene = scene;

        this.mouse = {
            x : 0,
            y : 0,
        }
    }


    setupResizeListener() {
        window.addEventListener('resize', () => {
            this.updateWindowSize();
        })
    }

    updateWindowSize() {
       this.scene.width = window.innerWidth; 
       this.scene.height = window.innerHeight;

       this.renderer.setSize(this.scene.width, this.scene.height);
       this.camera.aspect = this.scene.width / this.scene.height;
       this.camera.updateProjectionMatrix();
    }

    getMousePosition() {
        window.addEventListener('mousemove', (event) => {
            const screenSize = this.getScreenDemension();
            this.mouse.x = (event.clientX / window.innerWidth - 0.5) * screenSize.width;
            this.mouse.y = -(event.clientY / window.innerHeight - 0.5) * screenSize.height;
        })
    }

    getScreenDemension() {
        const fov = this.camera.fov * (Math.PI / 180);
        const height = 2 * Math.tan(fov / 2) * this.camera.position.z;
        const width = height * this.camera.aspect;

        return {
            width,
            height,
        }
    }

    getDistance(x1, y1, x2, y2) {
        return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
    }
}

// canvas
const canvas = document.querySelector('canvas.webgl');

// scene
const scene = new THREE.Scene();

// scene size
const size = {
    width: window.innerWidth,
    height: window.innerHeight
}

// Objects
const mouseGeo = new THREE.SphereGeometry(0.5, 16, 16);
const mouseMaterial = new THREE.MeshBasicMaterial({color : 'green', wireframe : true, });
const mouseMesh = new THREE.Mesh(mouseGeo, mouseMaterial);
scene.add(mouseMesh);

const geometry = new THREE.BoxGeometry(1,1,1);
const material = new THREE.MeshBasicMaterial({color : 'red', wireframe : true, });
const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);

// camera
const camera = new THREE.PerspectiveCamera(75, size.width / size.height, 0.1, 50);
camera.position.z = 5;
scene.add(camera);

// renderer
const renderer = new THREE.WebGLRenderer({
    canvas : canvas,
    antialias : true,
})

// setup first render
renderer.render(scene, camera);
renderer.setSize(size.width, size.height);

// Utils Methods
const utils = new Utils(canvas, renderer, camera, scene);
utils.setupResizeListener();
utils.getMousePosition();

// Animation
const followMouse = () => {
    mesh.position.x = utils.mouse.x;
    mesh.position.y = utils.mouse.y;

    mouseMesh.position.x = utils.mouse.x;
    mouseMesh.position.y = utils.mouse.y;
}

const makeLonger = () => {
    const distance = utils.getDistance(0,0, utils.mouse.x, utils.mouse.y);
    const scale = distance;
    mesh.scale.set(1,1, scale);
}


const animate = () => {
    requestAnimationFrame(animate);
    followMouse();
    makeLonger();
    renderer.render(scene, camera);
}

animate();