using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Candle : MonoBehaviour
{
    
    public GameObject light;
  
   
    bool state = true;

    private void Start()
    {
       
    }
    void OnTriggerStay(Collider col)
    {
        
        if (col.gameObject.tag == "Player" && Input.GetKeyUp(KeyCode.E))
        {
            if (state == true) state = false;
            else state = true;
            //switch the state 
        }
        light.SetActive(state);// turn on or off the light
        
        
    }

    private void OnTriggerExit(Collider other)
    {
       
    }


}
