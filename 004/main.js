import * as THREE from 'three';

// 004 : click and run

const canvas = document.querySelector('canvas.webgl');
const pointer = new THREE.Vector2();
const raycaster = new THREE.Raycaster();

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 100);
camera.position.z = 5;
const renderer = new THREE.WebGLRenderer({
    canvas: canvas
});

const geometry = new THREE.BoxGeometry(1, 1, 1);
const sphereGeometry = new THREE.SphereGeometry(1, 32, 32);

const material = new THREE.MeshBasicMaterial({color: 'red'});
const sphereMaterial = new THREE.MeshBasicMaterial({color: 'blue', transparent: true, opacity: 0.5, wireframe: true});
const mesh = new THREE.Mesh(geometry, material);
const sphereMesh = new THREE.Mesh(sphereGeometry, sphereMaterial);
scene.add(mesh);
scene.add(sphereMesh);

renderer.setSize(window.innerWidth, window.innerHeight);

window.addEventListener('resize', () => {
    renderer.setSize(window.innerWidth, window.innerHeight);
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
});

function onPointerMove(event)
{
    pointer.x = (event.clientX / window.innerWidth) * 2 - 1;
    pointer.y = -(event.clientY / window.innerHeight) * 2 + 1;
}

function followPointer(object)
{
    object.position.x = pointer.x;
    object.position.y = pointer.y;
}

window.addEventListener('pointermove', onPointerMove);

function render()
{
    raycaster.setFromCamera(pointer, camera);

    const intersects = raycaster.intersectObjects(scene.children);

    if(intersects.length > 0)
    {
        sphereMesh.visible = true;
        sphereMesh.rotation.x += 0.01;

        if(camera.position.z > mesh.position.z + 1)
        {
            camera.position.z -= 0.01;
            let sphereScale = camera.position.z * 0.3;
            sphereMesh.scale.set(sphereScale, sphereScale, sphereScale);
        }
    }
    else
    {
        sphereMesh.visible = false;
        if(camera.position.z < 5)
        {
            camera.position.z += 0.01;
        }
    }

    renderer.render(scene, camera);
    followPointer(sphereMesh);

    requestAnimationFrame(render);
}

render();

