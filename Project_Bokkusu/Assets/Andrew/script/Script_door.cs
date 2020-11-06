using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public class Script_door : MonoBehaviour
{
    Animator animator;
    bool doorOpen;
    public GameObject UI;
    
    void Start()
    {
        doorOpen = false;
        UI.SetActive(false);
        animator = GetComponent<Animator>();
    }

    void OnTriggerStay(Collider col)
    {
        if (col.gameObject.tag == "Player")
        {
            UI.SetActive(true);//if player in the area display the UI
        }
        if (col.gameObject.tag == "Player" && Input.GetKeyDown(KeyCode.E))
        {
            doorOpen = true;
            DoorControl("Open");
            //if player in the area && press E open the door
        }
    }
  
    void OnTriggerExit(Collider col)
    {
        if (doorOpen)
        {
            doorOpen = false;
            DoorControl("Close");
            //if player leave the area close the door
        }
        UI.SetActive(false);
        //if player leave the area, remove the UI
    }
    void DoorControl (string direction)
    {
        animator.SetTrigger(direction);
    }//function as switch
}
