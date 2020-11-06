using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Display_UI : MonoBehaviour
{
    public GameObject UI;
    public GameObject UI_narrative;
    bool state;
    // Start is called before the first frame update
    void Start()
    {
        UI.SetActive(false);
        UI_narrative.SetActive(false);

    }
    void OnTriggerStay(Collider col)
    {
        if (col.gameObject.tag == "Player")
        {
            UI.SetActive(true);
        }
        if (col.gameObject.tag == "Player" && Input.GetKeyDown(KeyCode.E))
        {
            //UI.GetComponent<Text>().text = " ";
            if (state == true) state = false;
            else state = true;
            //switch the state
            
        }
        UI_narrative.SetActive(state);




    }

    private void OnTriggerExit(Collider col)
    {
        if (col.gameObject.tag == "Player")
        {
            UI.SetActive(false);
            UI_narrative.SetActive(false);
            state = false;
            //remove the UI
        }
    }
    
    void Update()
    {
        print(UI_narrative.active);
    }
}
