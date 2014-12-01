using UnityEngine;
using System.Collections;

/// <summary>
/// Dissolve sample. 
/// 
/// Change dissolve texture to verify the dissolve effect.
/// </summary>
public class Dissolve : MonoBehaviour 
{
    public bool doRotate = false;
    public float rotDuration = 2f;

    void Start()
    {
        float to = 0f;
        float duration = 2f;
        
        // animating alpha to make a dissolve effect of the image.
        LTDescr descAlpha = LeanTween.alpha(this.gameObject, to, duration);
        descAlpha.setEase(LeanTweenType.linear);
        descAlpha.setLoopPingPong();

        if (doRotate)
        {
            LTDescr descRot = LeanTween.rotate(this.gameObject, new Vector3(180f, 30f, 90f), rotDuration);
            descRot.setLoopPingPong();
        }
    }

}
