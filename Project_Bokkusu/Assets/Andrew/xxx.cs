using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class xxx : MonoBehaviour
{
    private bool state = false;
    public GameObject character;
    private Vector3 forward;
    // Start is called before the first frame update
    void Start()
    {
        forward = character.transform.forward;
    }

    // Update is called once per frame
        void Update()
    {

    }

    void OnTriggerStay(Collider other)
    {
        if (other.tag == "Player")
        {
            print(character.transform.forward);
            this.GetComponent<Rigidbody>().AddRelativeForce(character.transform.forward * 20f);

            if (Input.GetMouseButton(0))
            {
                print(1);
                this.GetComponent<Rigidbody>().AddForce(forward * 10);
            }
             
        }
    }
      

     void OnTriggerExit(Collider other)
    {
        //if (other.tag == "Player")this.gameObject.GetComponentInChildren<Rigidbody>().isKinematic = true;
       }
}