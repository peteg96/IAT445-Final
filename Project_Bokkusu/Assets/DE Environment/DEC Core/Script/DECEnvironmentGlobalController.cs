#if UNITY_EDITOR
using UnityEditor;
using UnityEngine.Rendering;
#endif
using UnityEngine;
using System;

namespace DECEnvironment.WindController
{
    /// <summary>
    /// DE Environment Wind
    /// </summary>
    [ExecuteInEditMode]
    public class DECEnvironmentGlobalController : MonoBehaviour
    {
        #region PublicVariables
        public readonly string DECVersion = "1.0";
        /// <summary>
        ///Unity Wind Zone
        /// </summary>
        [SerializeField] public WindZone windZone;
        /// <summary>
        /// Wind Strength
        /// </summary>
        [SerializeField] public float WindStrength = 1;
        /// <summary>
        /// Wind Pulse
        /// </summary>
        [SerializeField] public float WindPulse = 0.1f;
        /// <summary>
        /// Wind Turbulence
        /// </summary>
        [SerializeField] public float WindTurbulence = 0.1f;
        /// <summary>
        /// Wind Randomness
        /// </summary>
        [SerializeField] public float WindRandomness = 0.2f;
        /// <summary>
        /// Billboard Wind
        /// </summary>
        [SerializeField] public bool BillboardWind = false;
        /// <summary>
        /// Billboard Wind Influence
        /// </summary>
        [SerializeField] public float BillboardWindInfluence = 0.5f;
        #endregion
        #region PrivateVariables
        private float windStrength;
        private float windDirection;
        private float windPulse;
        private float windTurbulence;
        [HideInInspector] public bool SynchWindZone;
        /// <summary>
        /// WindGizmo
        /// </summary>
        private GameObject windGizmo;
        /// <summary>
        /// Global Wind Shader Properties
        /// </summary>
        private readonly string windStr = "_WindStrength", windDir = "_WindDirection", windPls = "_WindPulse", windTur = "_WindTurbulence", BBrandom = "_RandomWindOffset",BBwindStr = "Billboard_WindStrength" ,BBenabled = "BillboardWindEnabled"; 
        #endregion
        #region UnityCalls
        /// <summary>
        /// Resets Global Wind to no Movement when disabled
        /// </summary>
        void OnDisable()
        {
            ResetShaders();
        }
        /// <summary>
        /// Resets Global Wind when component is removed
        /// </summary>
        void OnDestroy()
        {
            ResetShaders();
        }
        /// <summary>
        /// Initialize Windzone when component is enabled
        /// </summary>
        void OnEnable()
        {
            UpdateWind();
        }
        /// <summary>
        /// Updates Windzone every Frame
        /// </summary>
        void Update()
        {
            CheckUpdateValues();
        }
        /// <summary>
        /// Reset Component
        /// </summary>
        void Reset()
        {
            WindStrength = 1;
            WindTurbulence = 0.1f;
            WindRandomness = 0.2f;
            BillboardWind = false;
            BillboardWindInfluence = 0.5f;
            UpdateWind();

        }
        #endregion
        #region PublicVoids
        /// <summary>
        /// Check Update Values
        /// </summary>
        public void CheckUpdateValues()
        {
            if(windZone && SynchWindZone && (windZone.windMain != WindStrength || windZone.windPulseFrequency != WindPulse || windZone.windTurbulence != windTurbulence)){
                WindStrength = windZone.windMain;
                WindPulse = windZone.windPulseFrequency;
                WindTurbulence = windZone.windTurbulence;
                UpdateWind();
            }
            if (!SynchWindZone && (windStrength != GetGlobalFloatShaderValue(windStr) || transform.rotation.eulerAngles.y != GetGlobalFloatShaderValue(windDir) || windPulse != GetGlobalFloatShaderValue(windPls) || windTurbulence != GetGlobalFloatShaderValue(windTur)))
            {
                UpdateWind();
                windStrength = GetGlobalFloatShaderValue(windStr);
                windDirection = GetGlobalFloatShaderValue(windDir);
                windPulse = GetGlobalFloatShaderValue(windPls);
                windTurbulence = GetGlobalFloatShaderValue(windTur);
            }
        }
        /// <summary>
        /// Update Wind
        /// </summary>
        public void UpdateWind()
        {
            Shader.SetGlobalFloat(windStr, WindStrength);
            Shader.SetGlobalFloat(windDir, transform.rotation.eulerAngles.y);
            Shader.SetGlobalFloat(windPls, WindPulse);
            Shader.SetGlobalFloat(windTur, WindTurbulence);
            Shader.SetGlobalFloat(BBrandom, WindRandomness);
            if (BillboardWind)
            {
                Shader.SetGlobalInt(BBenabled, 1);
                Shader.SetGlobalFloat(BBwindStr, BillboardWindInfluence);
            }
            if (!BillboardWind)
            {
                Shader.SetGlobalInt(BBenabled, 0);
            }
        }
        /// <summary>
        /// Reset To Zero
        /// </summary>
        public void ResetShaders()
        {
            Shader.SetGlobalFloat(windStr, 0);
            Shader.SetGlobalFloat(windPls, 0);
            Shader.SetGlobalFloat(windTur, 0);
            Shader.SetGlobalFloat(BBrandom, 0);
            Shader.SetGlobalInt(BBenabled, 0);
            Shader.SetGlobalFloat(BBwindStr, 0);
            Shader.SetGlobalInt(BBenabled, 0);
        }
        #endregion
        #region PrivateVoid
 
        
        /// <summary>
        /// Get Global float Shader Value
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
        private float GetGlobalFloatShaderValue(string property)
        {
            return Shader.GetGlobalFloat(property);
        }

        #endregion
        #region UnityEditor
#if UNITY_EDITOR
        /// <summary>
        /// Create Global DE Enviroment Wind Controller
        /// </summary>
        [MenuItem("Window/DEC Environment/Tools/Add Global Controller...")]
        public static void CreateGlobalDECEnviromentWindController()
        {
            GameObject WindController = new GameObject("DEC Environment Global Controller");
            WindController.AddComponent<DECEnvironmentGlobalController>();
            if (SceneView.lastActiveSceneView != null)
            {
                WindController.transform.position = Vector3.zero;
            }
        }

#endif
        #endregion
    }
}