using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class state : MonoBehaviour
{
    public GameObject gamestate, chime1, chime2;
    int num = 0;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        num = chime1.GetComponent<grab>().num + chime2.GetComponent<grab>().num; //get results from chimes
        gamestate.GetComponent<TextMeshProUGUI>().text = "Find Chimes (" + num.ToString() + "/2)"; // show the results in UI
    }
}
