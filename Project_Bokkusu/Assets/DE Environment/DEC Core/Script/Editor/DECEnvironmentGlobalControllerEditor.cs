using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using DECEnvironment.WindController;


[CustomEditor(typeof(DECEnvironmentGlobalController))]
[CanEditMultipleObjects]
public class DECEnvironmentGlobalControllerEditor : Editor
{
    DECEnvironmentGlobalController controller;
    /// <summary>
    /// Wind Properties
    /// </summary>
    SerializedProperty WindStrength, WindPulse, WindTurbulence, WindRandomness, windZone;
    /// <summary>
    /// Billboard Properties
    /// </summary>
    SerializedProperty BillboardWind, BillboardWindInfluence;
    /// <summary>
    /// General Properties
    /// </summary>
    SerializedProperty synchWindZone;
    string windZoneButtonGUI;
    void OnEnable()
    {
        controller = (target as DECEnvironmentGlobalController);
        
        WindStrength = serializedObject.FindProperty("WindStrength");
        WindPulse = serializedObject.FindProperty("WindPulse");
        WindTurbulence = serializedObject.FindProperty("WindTurbulence");
        WindRandomness = serializedObject.FindProperty("WindRandomness");
        windZone = serializedObject.FindProperty("windZone");

        BillboardWind = serializedObject.FindProperty("BillboardWind");
        BillboardWindInfluence = serializedObject.FindProperty("BillboardWindInfluence");

        synchWindZone = serializedObject.FindProperty("SynchWindZone");

    }
    public override void OnInspectorGUI()
    {
        EditorGUI.BeginChangeCheck();
        
        EditorGUILayout.LabelField(("DEC Environment Global Controller " + controller.DECVersion),EditorStyles.boldLabel);
        EditorGUILayout.Space();

        EditorGUILayout.LabelField("General Settings", EditorStyles.miniBoldLabel);
        EditorGUILayout.BeginVertical("box");
        EditorGUI.BeginDisabledGroup(!controller.windZone);
        EditorGUILayout.PropertyField(synchWindZone, new GUIContent("Synch with WindZone"));       
        EditorGUI.EndDisabledGroup(); 
        EditorGUILayout.EndVertical();

        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Wind Settings", EditorStyles.miniBoldLabel);
        EditorGUILayout.BeginVertical("box");
        EditorGUILayout.PropertyField(windZone, new GUIContent("Wind Zone"));
        if(!controller.windZone){
            EditorGUILayout.BeginHorizontal();
            if (controller.GetComponent<WindZone>())
                windZoneButtonGUI = "Add attached Wind Zone";
            else
                windZoneButtonGUI = "Add new Wind Zone";
            if(GUILayout.Button(windZoneButtonGUI)){
                if(controller.GetComponent<WindZone>())
                    controller.windZone = controller.GetComponent<WindZone>();
                else
                    controller.windZone = controller.gameObject.AddComponent<WindZone>();
            }
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.Space();
        }
        EditorGUI.BeginDisabledGroup(controller.SynchWindZone && controller.windZone);
        EditorGUILayout.PropertyField(WindStrength, new GUIContent("Strength"));
        EditorGUILayout.PropertyField(WindTurbulence, new GUIContent("Turbulence"));
        EditorGUILayout.PropertyField(WindPulse, new GUIContent("Pulse Frequency"));
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.Slider(WindRandomness, 0, 1, new GUIContent("Randomness"));

        EditorGUILayout.Space();

        EditorGUILayout.LabelField("Billboard Wind Settings", EditorStyles.miniBoldLabel);
        EditorGUILayout.PropertyField(BillboardWind, new GUIContent("Enable Billoard Wind"));
        EditorGUI.BeginDisabledGroup(!controller.BillboardWind);
        EditorGUILayout.Slider(BillboardWindInfluence, 0, 1, new GUIContent("Strength"));
        EditorGUI.EndDisabledGroup();
        serializedObject.ApplyModifiedProperties();
        EditorGUILayout.EndVertical();
        if (EditorGUI.EndChangeCheck())
        {
            controller.UpdateWind();
        }
    }
}
