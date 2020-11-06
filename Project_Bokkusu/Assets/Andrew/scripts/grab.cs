using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Video;

public class grab : MonoBehaviour
{
    public int num = 0, state = 0; // state 0 for hint is not display, 1 for hint is display
    public GameObject text, sound;
    private void OnTriggerStay(Collider other)
    {
        if(num == 0 || state == 0)text.GetComponent<TextMeshProUGUI>().text = "Use 'E' to collect chime"; //show hints to user when they close to the object
        if (Input.GetKeyDown(KeyCode.E)) //get input key
            {
            sound.GetComponent<AudioSource>().Play(); // play sound effect
            this.gameObject.SetActive(false); //un active chime
            num = 1; //results of the interatcion
            state = 1; //change state
            text.GetComponent<TextMeshProUGUI>().text = " "; //hide hints
        }
    }

    private void OnTriggerExit(Collider other)
    {
        state = 1; //change state
        text.GetComponent<TextMeshProUGUI>().text = " "; //hide hints
    }
}
