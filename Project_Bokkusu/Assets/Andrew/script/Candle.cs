using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Candle : MonoBehaviour
{
    
    public GameObject light;
    public GameObject fire;
    public GameObject UI;
   
    bool state = true;

    private void Start()
    {
        UI.SetActive(false);
        //UI initially not displaying
    }
    void OnTriggerStay(Collider col)
    {
        UI.SetActive(true);//turn on the UI if player is in the area
        if (col.gameObject.tag == "Player" && Input.GetKeyUp(KeyCode.E))
        {
            if (state == true) state = false;
            else state = true;
            //switch the state 
        }
        light.SetActive(state);// turn on or off the light
        fire.SetActive(state);// display the fire or not
        
    }

    private void OnTriggerExit(Collider other)
    {
        UI.SetActive(false);
        //remove the UI
    }


}
