import * as THREE from 'three';
import { gsap } from "gsap";

const canvas = document.querySelector("canvas.webgl");

// scene
const scene = new THREE.Scene();

const size = {
    width: window.innerWidth,
    height: window.innerHeight,
};

// camera
const camera = new THREE.PerspectiveCamera(75, size.width / size.height, 0.1, 100);
camera.position.z = 5;

// object
const geometry = new THREE.BoxGeometry(1, 1, 1);

const geometry2 = new THREE.SphereGeometry(2, 5, 30);
const edges = new THREE.EdgesGeometry(geometry2);

// shader
const gradientMaterial = new THREE.ShaderMaterial({
    uniforms : {
        color1 : {value: new THREE.Color("#a18cd1")},
        color2 : {value: new THREE.Color("#fbc2eb")},
    },
    vertexShader: `
        varying vec2 vUv;
        void main() {
            vUv = uv;
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
    `,
    fragmentShader: `
        uniform vec3 color1;
        uniform vec3 color2;
        varying vec2 vUv;
        void main() {
            gl_FragColor = vec4(mix(color1, color2, vUv.y), 1.0);
        }
    `
});

const mesh = new THREE.Mesh(geometry, gradientMaterial);
const line = new THREE.LineSegments(edges, gradientMaterial);

gsap.to(mesh.rotation, {
    x: Math.PI * 2,
    y: Math.PI * 2,
    duration: 10,
    repeat: -1,
    ease: "bounce.inOut"
});

gsap.to(line.rotation, {
    x: Math.PI * 2,
    y: -Math.PI * 2,
    duration: 10,
    repeat: -1,
    ease: "bounce.inOut"
});

scene.add(mesh);
scene.add(line);
// resize
window.addEventListener("resize", () => {
    size.width = window.innerWidth;
    size.height = window.innerHeight;

    camera.aspect = size.width / size.height;
    camera.updateProjectionMatrix();
    renderer.setSize(size.width, size.height);
});

// renderer
const renderer = new THREE.WebGLRenderer({
    canvas : canvas,
    antialias : true,
});
renderer.setSize(size.width, size.height);

function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}

renderer.setAnimationLoop(animate);
